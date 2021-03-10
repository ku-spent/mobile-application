import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/di/di.dart';

import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/helper.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/hero_image_widget.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class QueryPage extends StatefulWidget {
  final QueryObject query;
  final String coverUrl;
  final bool isShowTitle;

  QueryPage({
    Key key,
    @required this.query,
    @required this.coverUrl,
    this.isShowTitle = false,
  }) : super(key: key);

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final ScrollController scrollController = ScrollController();
  final String _noResultImage = 'https://unsplash.com/a/img/empty-states/photos.png';
  String _heroTag;
  QueryFeedBloc _queryFeedBloc;

  ScrollController _scrollController;
  bool _isShowFloatingAction = false;

  final _minScrollThreshold = 50.0;
  final _scrollThreshold = 200.0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = scrollController;
    _scrollController.addListener(_onScroll);
    _heroTag = widget.coverUrl + 'cover' + getRandomString(10);
    // Future.delayed(Duration.zero, () {
    _queryFeedBloc = getIt<QueryFeedBloc>()..add(InitialQueryFeed(query: widget.query));
    // });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final minScroll = _scrollController.position.minScrollExtent + _minScrollThreshold;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll > minScroll && _isShowFloatingAction == false) {
      setState(() {
        _isShowFloatingAction = true;
      });
    } else if (currentScroll <= minScroll) {
      setState(() {
        _isShowFloatingAction = false;
      });
    } else if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchFeeds();
    }
  }

  void _fetchFeeds() {
    _queryFeedBloc.add(FetchQueryFeed());
  }

  void _onRefresh() async {
    _queryFeedBloc.add(RefreshQueryFeed());
  }

  void _scrollToTop() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeInExpo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: AnimatedOpacity(
        opacity: _isShowFloatingAction ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
            tooltip: 'Scroll to Top',
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
            onPressed: _scrollToTop,
            child: Icon(Icons.arrow_upward_rounded)),
      ),
      body: BlocProvider<QueryFeedBloc>(
        create: (BuildContext context) => _queryFeedBloc,
        child: BlocBuilder<QueryFeedBloc, QueryFeedState>(builder: (context, state) {
          if (state is QueryFeedInitial || state is QueryFeedLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QueryFeedLoaded) {
            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                    title: widget.isShowTitle
                        ? Text(
                            widget.query.title,
                            style: GoogleFonts.kanit(),
                          )
                        : null,
                    actions: [
                      PopupMenuButton(itemBuilder: (BuildContext context) {
                        return QueryPageOptions.choices
                            .map((choice) => PopupMenuItem(
                                value: choice,
                                child: Row(
                                  children: [
                                    QueryPageOptions.icons[choice],
                                    Container(
                                      width: 16,
                                    ),
                                    Text(choice)
                                  ],
                                )))
                            .toList();
                      })
                    ],
                    expandedHeight: 190.0,
                    stretch: true,
                    leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: [
                        StretchMode.zoomBackground,
                      ],
                      background: HeroImageViewWidget(tag: _heroTag, url: widget.coverUrl),
                    )),
                state.feeds.isEmpty
                    ? SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('No Results')],
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          List.generate(
                              state.hasMore ? state.feeds.length + 1 : state.feeds.length,
                              (index) => index >= state.feeds.length
                                  ? BottomLoader()
                                  : CardBase(
                                      news: state.feeds[index],
                                    )),
                        ),
                      )
                // SliverPadding(
                //     padding: EdgeInsets.only(top: 16.0),
                //     sliver: ,
                //   )
              ],
            );
          } else if (state is QueryFeedError) {
            return RetryError(callback: _onRefresh);
          }
        }),
      ),
    );
  }
}

class QueryPageOptions {
  static const String block = "ซ่อนเนื้อหาจากแหล่งข่าวนี้";

  static const Map<String, Icon> icons = {block: Icon(Icons.block, size: 24, color: Colors.black54)};

  static const List<String> choices = <String>[
    block,
  ];
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
