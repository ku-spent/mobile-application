import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/feed/feed_bloc.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/widgets/card_base.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  FeedBloc _feedBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _feedBloc = BlocProvider.of<FeedBloc>(context);
    Future.delayed(Duration.zero, () {
      _fetchFeeds();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
    print('fetch');
    _feedBloc.add(FetchFeed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedInitial) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FeedLoaded) {
        if (state.feeds.isEmpty) {
          return Center(
            child: Text('no feeds'),
          );
        }
        return Center(
            child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount:
              state.hasMore ? state.feeds.length + 1 : state.feeds.length,
          itemBuilder: (BuildContext context, int index) =>
              index >= state.feeds.length
                  ? BottomLoader()
                  : CardBase(news: state.feeds[index]),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 8,
          ),
          controller: _scrollController,
        ));
      }
      if (state is FeedError) {
        return Center(child: Text('Something went wrong!'));
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
