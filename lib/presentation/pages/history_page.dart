import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:spent/presentation/bloc/history/history_bloc.dart';
import 'package:spent/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/nav_drawer.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class HistoryPage extends StatefulWidget {
  final ScrollController scrollController = ScrollController();

  HistoryPage({Key key, this.title}) : super(key: key);

  final String title;

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

  void _onRefresh() async {
    _refreshController.refreshCompleted();
    // _historyBloc.add(RefreshFeed(callback: () => {_refreshController.refreshCompleted()}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (BuildContext context, NavigationState state) => Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text(
          PageName[state.selectedPage],
          style: GoogleFonts.kanit(),
        )),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryInitial || state is HistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoaded) {
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
            } else if (state is HistoryLoadError) {
              return RetryError();
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
