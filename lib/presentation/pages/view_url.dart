import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/widgets/source_icon.dart';

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

  Widget _buildAppbar() {
    return SliverAppBar(
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

  @override
  Widget build(BuildContext context) {
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
                  Row(children: [
                    SourceIcon(
                      source: _news.source,
                      width: 24.0,
                      height: 24.0,
                    ),
                    Container(
                      width: 12,
                    ),
                    Text(_news.source),
                    Text(' - '),
                    Text(DateFormat("วันที่ dd MMMM yyyy HH:mm น.", 'th')
                        .format(DateFormat("yyyy-MM-dd HH:mm:ssZ").parseUTC(_news.pubDate.toString()).toLocal()))
                  ])
                ],
              ),
            ),
            _buildHTML(_news),
          ])),
        ],
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
