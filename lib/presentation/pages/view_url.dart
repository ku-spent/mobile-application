import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/feed/feed_bloc.dart';
import 'package:spent/presentation/widgets/card_base.dart';
import 'package:spent/presentation/widgets/source_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewUrl extends StatefulWidget {
  final News news;

  const ViewUrl({Key key, @required this.news}) : super(key: key);

  @override
  _ViewUrlState createState() => _ViewUrlState();
}

class _ViewUrlState extends State<ViewUrl> {
  News _news;
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _news = widget.news;
  }

  Widget _buildHTML(News news) {
    return Html(
      data: news.rawHTMLContent,
      style: {
        "html": Style(backgroundColor: _backgroundColor),
        "a": Style(textDecoration: TextDecoration.none),
      },
    );
  }

  void _onSelectPageOption(String option) async {
    if (option == QueryPageOptions.open) {
      final String url = _news.url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
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
            background: Hero(
              tag: 'news-image-${_news.id}',
              child: CachedNetworkImage(
                imageUrl: _news.image,
                placeholder: (context, url) => Container(
                  color: Colors.black26,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            )));
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
                  .map((tag) => Badge(
                        elevation: 0,
                        toAnimate: false,
                        shape: BadgeShape.square,
                        badgeColor: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(16),
                        badgeContent: Text(tag, style: GoogleFonts.kanit(color: Colors.black87)),
                      ))
                  .toList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is FeedLoaded)
        return Scaffold(
          backgroundColor: _backgroundColor,
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildAppbar(),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.only(top: 16.0, right: 8.0, bottom: 0.0, left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_news.title, style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 16.0)),
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
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text('ข่าวที่เกี่ยวข้อง',
                            style: GoogleFonts.kanit(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          // aspectRatio: 2.0,
                          viewportFraction: 0.9,
                          autoPlayInterval: const Duration(seconds: 10),
                          // enlargeCenterPage: true,
                          height: 400,
                        ),
                        items: state.feeds
                            .where((news) => news.id != _news.id)
                            .toList()
                            .sublist(0, 5)
                            .map((news) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CardBase(
                                    news: news,
                                    isSubCard: true,
                                    showSummary: false,
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ])),
            ],
          ),
        );
    });
  }
}

class QueryPageOptions {
  static const String open = "เปิดในเบราว์เซอร์";

  static const Map<String, Icon> icons = {open: Icon(Icons.open_in_browser, size: 24, color: Colors.black54)};

  static const List<String> choices = <String>[
    open,
  ];
}
