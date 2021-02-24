import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

typedef BuildRecommendationItem({News news, int i});

class ForYouPage extends StatefulWidget {
  final ScrollController scrollController;
  final BuildRecommendationItem buildRecommendationItem;

  ForYouPage({Key key, this.scrollController, @required this.buildRecommendationItem}) : super(key: key);

  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> with AutomaticKeepAliveClientMixin<ForYouPage> {
  RecommendationBloc _feedBloc;
  final _scrollThreshold = 200.0;
  BuildRecommendationItem _buildItem;
  ScrollController _scrollController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _feedBloc = getIt<RecommendationBloc>();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _buildItem = widget.buildRecommendationItem;
    Future.delayed(Duration.zero, () async {
      _fetchRecommendations();
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _fetchRecommendations() {
    _feedBloc.add(FetchRecommendation());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchRecommendations();
    }
  }

  void _onRefresh() async {
    _feedBloc.add(RefreshRecommendation(callback: () => {_refreshController.refreshCompleted()}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecommendationBloc>(
      create: (BuildContext context) => _feedBloc,
      child: BlocBuilder<RecommendationBloc, RecommendationState>(
        builder: (context, state) {
          if (state is RecommendationInitial || state is RecommendationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecommendationLoaded) {
            if (state.recommendations.newsList.isEmpty) {
              return Center(
                child: Text('no feeds'),
              );
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: state.hasMore,
              header: WaterDropMaterialHeader(),
              physics: BouncingScrollPhysics(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: [
                  ImplicitlyAnimatedList<News>(
                    primary: false,
                    shrinkWrap: true,
                    items: state.recommendations.newsList,
                    physics: const BouncingScrollPhysics(),
                    removeDuration: const Duration(milliseconds: 200),
                    insertDuration: const Duration(milliseconds: 200),
                    updateDuration: const Duration(milliseconds: 200),
                    areItemsTheSame: (a, b) => a.id == b.id,
                    itemBuilder: (context, animation, result, i) {
                      return SizeFadeTransition(
                        key: ValueKey(result.id),
                        animation: animation,
                        child: _buildItem(news: result, i: i),
                      );
                    },
                    updateItemBuilder: (context, animation, result) {
                      return FadeTransition(
                        key: ValueKey(result.id),
                        opacity: animation,
                        child: _buildItem(news: result),
                      );
                    },
                    removeItemBuilder: (context, animation, result) {
                      return FadeTransition(
                        opacity: animation,
                        child: _buildItem(news: result),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (state is RecommendationError) {
            return RetryError(callback: _onRefresh);
          }
        },
      ),
    );
  }
}
