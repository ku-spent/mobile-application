import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/pages/home_page.dart';
import 'package:spent/presentation/widgets/card_base.dart';

class QueryPage extends StatefulWidget {
  final String query;
  final String queryField;
  final String coverUrl;
  final bool isShowTitle;

  QueryPage({
    Key key,
    @required this.query,
    @required this.queryField,
    @required this.coverUrl,
    this.isShowTitle = false,
  }) : super(key: key);

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final ScrollController scrollController = ScrollController();
  final _noResultImage = 'https://unsplash.com/a/img/empty-states/photos.png';
  QueryFeedBloc _sourceBloc;
  ScrollController _scrollController;
  bool _isShowFloatingAction = false;

  final _minScrollThreshold = 50.0;
  final _scrollThreshold = 200.0;
  // final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = scrollController;
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () {
      _sourceBloc = BlocProvider.of<QueryFeedBloc>(context);
      _sourceBloc.add(InitialQueryFeed(query: widget.query, queryField: widget.queryField));
    });
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
    _sourceBloc.add(FetchQueryFeed());
  }

  // void _onRefresh() async {
  //   _sourceBloc.add(RefreshSource(
  //       source: widget.source,
  //       callback: () => {_refreshController.refreshCompleted()}));
  // }

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
      body: BlocBuilder<QueryFeedBloc, QueryFeedState>(builder: (context, state) {
        if (BlocProvider.of<QueryFeedBloc>(context).query != widget.query || state is QueryFeedInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is QueryFeedLoaded) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                  title: widget.isShowTitle
                      ? Text(
                          widget.query,
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
                    background: CachedNetworkImage(
                      imageUrl: widget.coverUrl,
                      placeholder: (context, url) => Container(
                        color: Colors.black26,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  )),
              state.feeds.isEmpty
                  ? SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('No Results')],
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.only(top: 16.0),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          List.generate(
                            state.hasMore ? state.feeds.length + 1 : state.feeds.length,
                            (index) => index >= state.feeds.length
                                ? BottomLoader()
                                : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    child: CardBase(
                                      news: state.feeds[index],
                                      canClickSource: false,
                                      canClickCategory: false,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    )
            ],
          );
        } else if (state is QueryFeedError) {
          return Center(child: Text('Something went wrong!'));
        }
      }),
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
