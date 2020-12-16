import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedInitial) {
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
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.feeds.length,
            itemBuilder: (BuildContext context, int index) => CardBase(
              news: state.feeds[index],
              key: UniqueKey(),
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 8,
            ),
            controller: _scrollController,
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
