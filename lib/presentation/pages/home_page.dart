import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/keep_alive_page.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class HomePage extends StatefulWidget {
  final ScrollController scrollController;
  HomePage({Key key, this.title, @required this.scrollController}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FeedBloc _feedBloc;
  ScrollController _scrollController;
  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    _feedBloc = BlocProvider.of<FeedBloc>(context);
    Future.delayed(Duration.zero, () async {
      _fetchFeeds();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchFeeds();
    }
  }

  void _fetchFeeds() {
    _feedBloc.add(FetchFeed());
  }

  void _onRefresh() async {
    _feedBloc.add(RefreshFeed(callback: () => {_refreshController.refreshCompleted()}));
  }

  Widget _buildItem(BuildContext context, News news) {
    return CardBase(
      news: news,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
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
                    child: _buildItem(context, result),
                  );
                },
                updateItemBuilder: (context, animation, result) {
                  return FadeTransition(
                    key: ValueKey(result.id),
                    opacity: animation,
                    child: _buildItem(context, result),
                  );
                },
                removeItemBuilder: (context, animation, result) {
                  return FadeTransition(
                    opacity: animation,
                    child: _buildItem(context, result),
                  );
                },
              )
            ],
          ),
        );
      } else if (state is FeedError) {
        return RetryError(callback: _onRefresh);
      }
    });
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
