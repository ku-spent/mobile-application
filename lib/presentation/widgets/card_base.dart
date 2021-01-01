import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/presentation/bloc/like_news/like_news_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/news_action.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/presentation/bloc/save_bookmark/save_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';
import 'package:spent/presentation/pages/query_page.dart';
import 'package:spent/presentation/widgets/source_icon.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'card_base.part.dart';

class CardBase extends StatefulWidget {
  final News news;
  final bool showPicture;

  CardBase({
    Key key,
    @required this.news,
    this.showPicture = true,
  }) : super(key: key);

  @override
  _CardBaseState createState() => _CardBaseState();
}

class _CardBaseState extends State<CardBase> with SingleTickerProviderStateMixin {
  News _news;
  bool _isBookmarked = false;
  String _likeStatus = NewsAction.noneLike;
  NewsAction _newsAction = NewsAction(likeStatus: 'like');
  UserEventBloc _userEventBloc;
  SaveBookmarkBloc _saveBookmarkBloc;
  LikeNewsBloc _likeNewsBloc;

  @override
  void initState() {
    super.initState();
    _userEventBloc = BlocProvider.of<UserEventBloc>(context);
    _saveBookmarkBloc = BlocProvider.of<SaveBookmarkBloc>(context);
    _likeNewsBloc = BlocProvider.of<LikeNewsBloc>(context);
    _news = widget.news;
    _isBookmarked = _news.isBookmarked;
    // final bookmark = _news.isBookmarked;
    // print('news bookmark: $bookmark');
  }

  void _goToLink(BuildContext context) async {
    await launch(
      _news.url,
      option: CustomTabsOption(
        toolbarColor: Theme.of(context).primaryColor,
        enableDefaultShare: true,
        enableUrlBarHiding: false,
        showPageTitle: true,
        animation: CustomTabsAnimation.slideIn(),
        extraCustomTabs: const <String>[
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
    );
    _userEventBloc.add(ReadNewsEvent(news: _news));
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
    _likeNewsBloc.add(LikeNews(news: _news));
    setState(() {
      _likeStatus = _likeStatus == NewsAction.like ? NewsAction.noneLike : NewsAction.like;
    });
  }

  void _onClickDislike() {
    setState(() {
      _likeStatus = _likeStatus == NewsAction.dislike ? NewsAction.noneLike : NewsAction.dislike;
    });
  }

  void _setIsBookmarked(bool isBookmarked) {
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  void _onClickBookmark() {
    _saveBookmarkBloc.add(SaveBookmark(news: _news));
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SaveBookmarkBloc, SaveBookmarkState>(listener: (context, state) {
          if (state is SaveBookmarkSuccess && state.news.id == _news.id) {
            _setIsBookmarked(state.result.isBookmarked);
          }
        }),
        BlocListener<UserEventBloc, UserEventState>(listener: (context, state) {}),
        BlocListener<LikeNewsBloc, LikeNewsState>(listener: (context, state) {})
      ],
      child: Container(
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          shadowColor: Theme.of(context).primaryColorLight,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            child: Container(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildContent(widget.showPicture),
                  _buildBottom(),
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
      ),
    );
  }
}
