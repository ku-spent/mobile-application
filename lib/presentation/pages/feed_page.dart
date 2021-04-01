import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

typedef BuildFeedItem({News news, int i});

class FeedPage extends StatefulWidget {
  final ScrollController scrollController;
  final BuildFeedItem buildFeedItem;

  FeedPage({Key key, this.scrollController, @required this.buildFeedItem}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with AutomaticKeepAliveClientMixin<FeedPage> {
  FeedBloc _feedBloc;
  double _scrollThreshold;
  BuildFeedItem _buildItem;
  ScrollController _scrollController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _feedBloc = getIt<FeedBloc>();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _buildItem = widget.buildFeedItem;
    Future.delayed(Duration.zero, () async {
      _fetchFeeds();
      _scrollThreshold = 2 * MediaQuery.of(context).size.height;
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _fetchFeeds() {
    _feedBloc.add(FetchFeed());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchFeeds();
    }
  }

  void _onRefresh() async {
    _feedBloc.add(RefreshFeed(callback: () => {_refreshController.refreshCompleted()}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBloc>(
      create: (BuildContext context) => _feedBloc,
      child: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedInitial || state is FeedLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            if (state.feeds.isEmpty) {
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
                    items: state.feeds,
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
                        key: ValueKey(result.id),
                        opacity: animation,
                        child: _buildItem(news: result),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (state is FeedError) {
            return RetryError(callback: _onRefresh);
          }
        },
      ),
    );
  }
}
