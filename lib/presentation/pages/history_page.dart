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
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/manage_history/manage_history_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/in_page_search_bar.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class HistoryPage extends StatefulWidget {
  static String title = 'ดูล่าสุด';

  final ScrollController scrollController = ScrollController();

  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _query = '';
  HistoryBloc _historyBloc;
  ManageHistoryBloc _manageHistoryBloc;
  ScrollController _scrollController;

  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () async {
      _historyBloc = BlocProvider.of<HistoryBloc>(context);
      _manageHistoryBloc = BlocProvider.of<ManageHistoryBloc>(context);
      _refreshHistories();
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
      _fetchHistories();
    }
  }

  void _fetchHistories() {
    _historyBloc.add(FetchHistory(query: _query));
  }

  void _refreshHistories() {
    _historyBloc.add(RefreshHistory(query: _query));
  }

  void _onRefresh() async {
    _historyBloc.add(RefreshHistory(query: _query, callback: _refreshController.refreshCompleted));
  }

  void _onDelete(News news) async {
    _manageHistoryBloc.add(DeleteHistory(news: news));
  }

  void _onQueryChanged(String query) {
    setState(() {
      _query = query;
    });
    _refreshHistories();
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
      body: BlocListener<ManageHistoryBloc, ManageHistoryState>(
        listener: (context, state) {
          if (state is SaveHistorySuccess) {
            _refreshHistories();
          } else if (state is DeleteHistorySuccess) {
            _historyBloc.add(RemoveHistoryFromList(news: state.news));
            BotToast.showText(
              text: 'ลบเสร็จสิ้น',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryInitial || state is HistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
              return InPageSearchBar(
                title: HistoryPage.title,
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
                      state.news.isEmpty ? Center(child: Text('no history.')) : Container(),
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
            } else if (state is HistoryLoadError) {
              return RetryError(callback: _onRefresh);
            }
          },
        ),
      ),
      // ),
    );
  }
}
