import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/bloc/save_history/save_history_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class HistoryPage extends StatefulWidget {
  static String title = 'History';

  final ScrollController scrollController = ScrollController();

  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryBloc _historyBloc;
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
    _historyBloc.add(FetchHistory());
  }

  void _refreshHistories() {
    _historyBloc.add(RefreshHistory());
  }

  void _onRefresh() async {
    _historyBloc.add(RefreshHistory(callback: _refreshController.refreshCompleted));
  }

  Widget _buildItem(BuildContext context, News news) {
    return CardBase(
      news: news,
      showSummary: false,
      showPicture: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(HistoryPage.title, style: GoogleFonts.kanit())),
      body: BlocListener<SaveHistoryBloc, SaveHistoryState>(
        listener: (context, state) {
          if (state is SaveHistorySuccess) {
            _refreshHistories();
          }
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoaded) {
              if (state.news.isEmpty) {
                return Center(
                  child: Text('no histories'),
                );
              } else {
                return SmartRefresher(
                  enablePullDown: true,
                  // enablePullUp: state.hasMore,
                  header: WaterDropMaterialHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ImplicitlyAnimatedList<News>(
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
                );
              }
            } else if (state is HistoryLoadError) {
              return RetryError(callback: _onRefresh);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      // ),
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
