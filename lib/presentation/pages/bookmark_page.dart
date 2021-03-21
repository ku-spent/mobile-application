import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/presentation/bloc/bookmark/bookmark_bloc.dart';
import 'package:spent/presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/in_page_search_bar.dart';
import 'package:spent/presentation/widgets/no_result.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class BookmarkPage extends StatefulWidget {
  static String title = 'บุ๊คมาร์ค';

  BookmarkPage({Key key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  String _query = '';
  BookmarkBloc _bookmarkBloc;
  ManageBookmarkBloc _manageBookmarkBloc;
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
      _manageBookmarkBloc = BlocProvider.of<ManageBookmarkBloc>(context);
      _refreshBookmarks();
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
    if ((maxScroll - currentScroll) > 0 && (maxScroll - currentScroll <= _scrollThreshold)) {
      _fetchBookmarks();
    }
  }

  void _fetchBookmarks() {
    print('fetch bookmarks');
    _bookmarkBloc.add(FetchBookmark(query: _query));
  }

  void _refreshBookmarks() {
    print('refresh bookmarks');
    _bookmarkBloc.add(RefreshBookmark(query: _query));
  }

  void _onRefresh() async {
    _bookmarkBloc.add(RefreshBookmark(query: _query, callback: () => {_refreshController.refreshCompleted()}));
  }

  void _onDelete(News news) async {
    _manageBookmarkBloc.add(DeleteBookmark(news: news));
  }

  void _onQueryChanged(String query) {
    setState(() {
      _query = query;
    });
    _refreshBookmarks();
  }

  Widget _buildItem(BuildContext context, News news) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        actionPane: const SlidableBehindActionPane(),
        child: CardBase(
          news: news,
          isSecondary: true,
          showBottom: false,
          margin: EdgeInsets.zero,
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _onDelete(news),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ManageBookmarkBloc, ManageBookmarkState>(
        listener: (context, state) {
          if (state is SaveBookmarkSuccess) {
            print('save ${state.news.id}');
            _refreshBookmarks();
          } else if (state is DeleteBookmarkSuccess) {
            _bookmarkBloc.add(RemoveNewsFromList(news: state.news));
            BotToast.showText(
              text: 'ลบเสร็จสิ้น',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        },
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkInitial || state is BookmarkLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookmarkLoaded) {
              return InPageSearchBar(
                title: BookmarkPage.title,
                hint: 'ค้นหา',
                onQueryChanged: _onQueryChanged,
                onSubmitted: _onQueryChanged,
                body: SmartRefresher(
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
                      state.news.isEmpty ? NoResult() : Container(),
                      ImplicitlyAnimatedList<News>(
                        shrinkWrap: true,
                        items: state.news,
                        physics: const NeverScrollableScrollPhysics(),
                        removeDuration: const Duration(milliseconds: 100),
                        insertDuration: const Duration(milliseconds: 100),
                        updateDuration: const Duration(milliseconds: 100),
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
                            key: ValueKey(result.id),
                            opacity: animation,
                            child: _buildItem(context, result),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is BookmarkLoadError) {
              return RetryError(callback: _onRefresh);
            }
          },
        ),
      ),
    );
  }
}
