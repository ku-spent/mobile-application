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
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchFeeds();
    });
  }

  void _fetchFeeds() {
    BlocProvider.of<FeedBloc>(context).add(FetchFeed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is FeedLoaded) {
        return Center(
            child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.feeds.length,
          itemBuilder: (BuildContext context, int index) =>
              CardBase(news: state.feeds[index]),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: 8,
          ),
        ));
      }
      return Center(child: Text('Something went wrong!'));
    });
  }
}
