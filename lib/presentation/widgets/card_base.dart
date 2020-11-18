import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news.dart';
import 'package:spent/domain/model/news_action.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/presentation/pages/query_page.dart';
import 'package:spent/presentation/pages/webview.dart';
import 'package:spent/presentation/widgets/source_icon.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardBase extends StatefulWidget {
  final News news;
  final bool canClickSource;
  final bool canClickCategory;

  CardBase({
    Key key,
    @required this.news,
    this.canClickSource = true,
    this.canClickCategory = true,
  }) : super(key: key);

  @override
  _CardBaseState createState() => _CardBaseState();
}

class _CardBaseState extends State<CardBase> with SingleTickerProviderStateMixin {
  News _news;
  bool _isBookmarked = false;
  String _likeStatus = NewsAction.noneLike;
  NewsAction _newsAction = NewsAction(likeStatus: 'like');

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

  void _goToQuerySourcePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: false,
        builder: (context) => QueryPage(
          query: _news.source,
          queryField: QueryField.source,
          coverUrl: NewsSource.newsSourceCover[_news.source],
        ),
      ),
    );
  }

  void _goToQueryCategoryPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: false,
        builder: (context) => QueryPage(
          isShowTitle: true,
          query: _news.category,
          queryField: QueryField.category,
          coverUrl: Category.newsCategoryCover[_news.category],
        ),
      ),
    );
  }

  void _onClickLike() {
    setState(() {
      _likeStatus = _likeStatus == NewsAction.like ? NewsAction.noneLike : NewsAction.like;
    });
  }

  void _onClickDislike() {
    setState(() {
      _likeStatus = _likeStatus == NewsAction.dislike ? NewsAction.noneLike : NewsAction.dislike;
    });
  }

  void _onClickBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  Widget _buildIcon({Function onPressed, Icon inActive, Icon active, bool isActive}) {
    return IconButton(
      color: isActive ? Theme.of(context).primaryColor : Colors.grey,
      onPressed: onPressed,
      icon: isActive ? active : inActive,
    );
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
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IgnorePointer(
                      ignoring: !widget.canClickSource,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () => _goToQuerySourcePage(context),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            children: [
                              SourceIcon(
                                source: _news.source,
                              ),
                              Container(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _news.source,
                                    style: GoogleFonts.kanit(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    timeago.format(_news.pubDate, locale: 'th'),
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildIcon(
                      isActive: _isBookmarked,
                      active: Icon(Icons.bookmark),
                      inActive: Icon(Icons.bookmark_outline),
                      onPressed: _onClickBookmark,
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => _goToLink(context),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: _news.image,
                              placeholder: (context, url) => Container(
                                color: Colors.black26,
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                      IgnorePointer(
                        ignoring: !widget.canClickCategory,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () => _goToQueryCategoryPage(context),
                          child: Text(
                            '#' + _news.category,
                            style: GoogleFonts.kanit(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Row(children: [
                        _buildIcon(
                          isActive: _likeStatus == NewsAction.like,
                          active: Icon(Icons.thumb_up),
                          inActive: Icon(Icons.thumb_up_outlined),
                          onPressed: _onClickLike,
                        ),
                        _buildIcon(
                          isActive: _likeStatus == NewsAction.dislike,
                          active: Icon(Icons.thumb_down),
                          inActive: Icon(Icons.thumb_down_outlined),
                          onPressed: _onClickDislike,
                        ),
                      ]),
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
