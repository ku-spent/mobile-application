import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:spent/di/di.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/widgets/source_icon.dart';
import 'package:spent/presentation/widgets/webview_bottom.dart';
import 'package:spent/presentation/widgets/suggest_carousel.dart';
import 'package:spent/presentation/bloc/suggest/suggest_bloc.dart';
import 'package:spent/presentation/widgets/hero_image_widget.dart';
import 'package:spent/ext/scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';
import 'package:spent/ext/scroll_bottom_navigation_bar/scroll_bottom_navigation_bar_controller.dart';

class ViewUrl extends StatefulWidget {
  final News news;

  const ViewUrl({Key key, @required this.news}) : super(key: key);

  @override
  _ViewUrlState createState() => _ViewUrlState();
}

class _ViewUrlState extends State<ViewUrl> {
  News _news;
  Color _backgroundColor = Colors.white;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _news = widget.news;
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.bottomNavigationBar.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _customImg(
    BuildContext context,
    Map<String, String> attributes,
  ) {
    final String url = attributes['src'];
    final String tag = _news.id + url;
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Center(child: HeroImageViewWidget(tag: tag, url: url)),
    );
  }

  Widget _buildHTML(News news) {
    final _imageRender = (ctx, parsedChild, attributes, _) => _customImg(context, attributes);
    return Html(
      data: news.rawHTMLContent,
      customRender: Map.from({'img': _imageRender}),
      style: {
        "html": Style(
          backgroundColor: _backgroundColor,
          fontFamily: GoogleFonts.sarabun().fontFamily,
        ),
        "h1": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "h2": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "h3": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "h4": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "h5": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "h6": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        ),
        "p": Style(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          lineHeight: 1.6,
          letterSpacing: 0.4,
          fontSize: FontSize(18.0),
        ),
        "strong": Style(
          fontWeight: FontWeight.bold,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          lineHeight: 1.6,
          letterSpacing: 0.4,
          fontSize: FontSize(18.0),
        ),
        "a": Style(
          textDecoration: TextDecoration.none,
          color: Colors.black87,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
        ),
        "ul": Style(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.only(left: 4.0),
        )
      },
    );
  }

  void _onSelectPageOption(String option) async {
    if (option == QueryPageOptions.open) {
      final String url = _news.url;
      await launch(url, enableJavaScript: false);
    }
  }

  Widget _buildAppbar() {
    return SliverAppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
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
            },
            onSelected: _onSelectPageOption,
          )
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
          background: HeroImageViewWidget(tag: _news.id + 'cover', url: _news.image),
        ));
  }

  Widget _buildSourceTitle(News news) {
    return Row(children: [
      SourceIcon(
        source: news.source,
        width: 24.0,
        height: 24.0,
      ),
      Container(
        width: 12,
      ),
      Text(news.source),
      Text(' - '),
      Text(DateFormat("วันที่ dd MMMM yyyy HH:mm น.", 'th')
          .format(DateFormat("yyyy-MM-dd HH:mm:ssZ").parseUTC(news.pubDate.toString()).toLocal()))
    ]);
  }

  Widget _buildBadge() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: _news.tags
                  .map(
                    (tag) => InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        child: Badge(
                          elevation: 0,
                          toAnimate: false,
                          shape: BadgeShape.square,
                          badgeColor: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(16),
                          badgeContent: Text(tag, style: GoogleFonts.kanit(color: Colors.black87)),
                        ),
                        onTap: () {
                          ExtendedNavigator.of(context).push(
                            Routes.queryPage,
                            arguments: QueryPageArguments(
                                query: QueryWithField(tag, query: tag, queryField: QueryField.tags),
                                isShowTitle: true,
                                coverUrl: Category.newsCategoryCover[Category.localNews]),
                          );
                        }),
                  )
                  .toList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SuggestFeedBloc>(
      lazy: false,
      create: (BuildContext context) => getIt<SuggestFeedBloc>()..add(InitialSuggestFeed(curNews: _news)),
      child: Scaffold(
        bottomNavigationBar: ScrollBottomNavigationBar(
          child: WebViewBottom(news: _news),
          controller: _scrollController,
        ),
        backgroundColor: _backgroundColor,
        extendBodyBehindAppBar: true,
        body: ValueListenableBuilder<int>(
          valueListenable: _scrollController.bottomNavigationBar.tabNotifier,
          builder: (context, tabIndex, child) => CustomScrollView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              _buildAppbar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.only(top: 16.0, right: 8.0, bottom: 0.0, left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_news.title, style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 24.0)),
                        Container(height: 8.0),
                        _buildSourceTitle(_news),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(child: _buildHTML(_news)),
                  _buildBadge(),
                  Container(height: 8.0),
                  Divider(),
                  SuggestCarousel(
                    curNews: _news,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QueryPageOptions {
  static const String open = "เปิดในเบราว์เซอร์";

  static const Map<String, Icon> icons = {open: Icon(Icons.open_in_browser, size: 24, color: Colors.black54)};

  static const List<String> choices = <String>[
    open,
  ];
}
