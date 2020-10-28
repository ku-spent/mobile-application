import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spent/bloc/source/source_bloc.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/pages/home_page.dart';
import 'package:spent/ui/widgets/card_base.dart';

class SourcePage extends StatefulWidget {
  final String source;

  SourcePage({Key key, this.source}) : super(key: key);

  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  final ScrollController scrollController = ScrollController();

  void _scrollToTop() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeInExpo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
          onPressed: _scrollToTop,
          child: Icon(Icons.arrow_upward_rounded)),
      body: SourceContent(
          source: widget.source, scrollController: scrollController),
    );
  }
}

class SourceContent extends StatefulWidget {
  final String source;
  final ScrollController scrollController;

  SourceContent(
      {Key key, @required this.source, @required this.scrollController})
      : super(key: key);

  @override
  _SourceContentState createState() => _SourceContentState();
}

class _SourceContentState extends State<SourceContent> {
  SourceBloc _sourceBloc;
  ScrollController _scrollController;

  final _scrollThreshold = 200.0;
  // final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () {
      _sourceBloc = BlocProvider.of<SourceBloc>(context);
      _sourceBloc.add(InitialSource(source: widget.source));
    });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _fetchFeeds();
    }
  }

  void _fetchFeeds() {
    _sourceBloc.add(FetchSource());
  }

  // void _onRefresh() async {
  //   _sourceBloc.add(RefreshSource(
  //       source: widget.source,
  //       callback: () => {_refreshController.refreshCompleted()}));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourceBloc, SourceState>(builder: (context, state) {
      if (context.bloc<SourceBloc>().source != widget.source ||
          state is SourceInitial) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SourceLoaded) {
        if (state.feeds.isEmpty) {
          return Center(
            child: Text('no feeds'),
          );
        }
        return CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
                actions: [
                  PopupMenuButton(itemBuilder: (BuildContext context) {
                    return SourcePageOptions.choices
                        .map((choice) => PopupMenuItem(
                            value: choice,
                            child: Row(
                              children: [
                                SourcePageOptions.icons[choice],
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
                    imageUrl: NewsSource.newsSourceCover[widget.source],
                    placeholder: (context, url) => Container(
                      color: Colors.black26,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                )),
            SliverPadding(
                padding: EdgeInsets.only(top: 16.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(List.generate(
                        state.hasMore
                            ? state.feeds.length + 1
                            : state.feeds.length,
                        (index) => index >= state.feeds.length
                            ? BottomLoader()
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: CardBase(
                                  news: state.feeds[index],
                                  canClickSource: false,
                                ),
                              )))))
          ],
        );
      } else if (state is SourceError) {
        return Center(child: Text('Something went wrong!'));
      }
    });
  }
}

class SourcePageOptions {
  static const String block = "ซ่อนเนื้อหาจากแหล่งข่าวนี้";

  static const Map<String, Icon> icons = {
    block: Icon(Icons.block, size: 24, color: Colors.black54)
  };

  static const List<String> choices = <String>[
    block,
  ];
}
