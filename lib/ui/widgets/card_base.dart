import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:spent/ui/pages/webview.dart';
import 'package:spent/ui/widgets/source_icon.dart';
import 'package:timeago/timeago.dart' as timeago;

enum LikeStatus { like, unlike, none }

class CardBase extends StatefulWidget {
  final News news;

  CardBase({Key key, @required this.news}) : super(key: key);

  @override
  _CardBaseState createState() => _CardBaseState();
}

class _CardBaseState extends State<CardBase> {
  News _news;

  LikeStatus _likeStatus = LikeStatus.none;

  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _news = widget.news;
  }

  void _goToLink(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.push(
          context,
          CupertinoPageRoute(
              maintainState: false,
              builder: (context) => WebViewPage(
                    news: _news,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shadowColor: Theme.of(context).primaryColorLight,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          child: Container(
            width: 360,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SourceIcon(
                          source: _news.source,
                        ),
                        Container(
                          width: 8,
                        ),
                        Text(
                          _news.source,
                        )
                      ],
                    ),
                    IconButton(
                      icon: _isBookmarked
                          ? Icon(Icons.bookmark)
                          : Icon(Icons.bookmark_border),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => {},
                    )
                  ],
                ),
                InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => _goToLink(context),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: _news.image,
                              placeholder: (context, url) => Container(
                                color: Colors.black26,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Text(
                        _news.title,
                        style: Theme.of(context).textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _news.summary,
                        style: Theme.of(context).textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeago.format(_news.pubDate, locale: 'th'),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Row(children: [
                        IconButton(
                          icon: _likeStatus == LikeStatus.like
                              ? Icon(Icons.thumb_up)
                              : Icon(Icons.thumb_up_outlined),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => {},
                        ),
                        IconButton(
                          icon: _likeStatus == LikeStatus.unlike
                              ? Icon(Icons.thumb_down)
                              : Icon(Icons.thumb_down_outlined),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => {},
                        )
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorLight.withOpacity(.08),
            blurRadius: 16.0,
          ),
        ],
      ),
    );
  }
}
