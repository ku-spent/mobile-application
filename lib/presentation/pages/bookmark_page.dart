import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:spent/presentation/bloc/save_bookmark/save_bookmark_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class BookmarkPage extends StatefulWidget {
  static String title = 'Bookmark';

  BookmarkPage({Key key}) : super(key: key);

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
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () async {
      _bookmarkBloc = BlocProvider.of<BookmarkBloc>(context);
      _fetchBookmarks();
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
      _fetchBookmarks();
    }
  }

  void _fetchBookmarks() {
    print('fetch bookmarks');
    _bookmarkBloc.add(FetchBookmark());
  }

  void _refreshBookmarks() {
    print('refresh bookmarks');
    _bookmarkBloc.add(RefreshBookmark());
  }

  void _onRefresh() async {
    _bookmarkBloc.add(RefreshBookmark(callback: () => {_refreshController.refreshCompleted()}));
  }

  Widget _buildItem(BuildContext context, News news) {
    return CardBase(
      news: news,
      isSecondary: true,
      showBottom: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          BookmarkPage.title,
          style: GoogleFonts.kanit(),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<SaveBookmarkBloc, SaveBookmarkState>(
        listener: (context, state) {
          if (state is SaveBookmarkSuccess) {
            _refreshBookmarks();
          }
        },
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
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
                  enablePullUp: state.hasMore,
                  header: WaterDropMaterialHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      ImplicitlyAnimatedList<News>(
                        shrinkWrap: true,
                        items: state.news,
                        physics: const NeverScrollableScrollPhysics(),
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
                      ),
                    ],
                  ),
                );
              }
            } else if (state is BookmarkLoadError) {
              return RetryError(callback: _onRefresh);
            }
          },
        ),
      ),
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
