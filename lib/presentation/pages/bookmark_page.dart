import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class BookmarkPage extends StatefulWidget {
  final ScrollController scrollController;
  BookmarkPage({Key key, this.title, @required this.scrollController}) : super(key: key);

  final String title;

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  BookmarkBloc _bookmarkBloc;
  ScrollController _scrollController;
  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () async {
      _bookmarkBloc = BlocProvider.of<BookmarkBloc>(context);
      _fetchHistories();
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
      // _fetchHistories();
    }
  }

  void _fetchHistories() {
    _bookmarkBloc.add(FetchBookmark());
  }

  void _onRefresh() async {
    _refreshController.refreshCompleted();
    // _bookmarkBloc.add(RefreshFeed(callback: () => {_refreshController.refreshCompleted()}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is BookmarkInitial || state is BookmarkLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BookmarkLoaded) {
          if (state.news.isEmpty) {
            return Center(
              child: Text('no bookmarks'),
            );
          } else {
            return SmartRefresher(
              enablePullDown: true,
              // enablePullUp: state.hasMore,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.news.length,
                itemBuilder: (BuildContext context, int index) => CardBase(
                  key: UniqueKey(),
                  news: state.news[index],
                  showPicture: false,
                ),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 8,
                ),
                controller: _scrollController,
              ),
            );
          }
        } else if (state is BookmarkLoadError) {
          return RetryError();
        }
      },
    );
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
