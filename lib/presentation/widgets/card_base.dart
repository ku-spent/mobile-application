import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/like_news/like_news_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/presentation/bloc/save_bookmark/save_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/user_event/user_event_bloc.dart';
import 'package:spent/presentation/widgets/source_icon.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'card_base.part.dart';

class CardBase extends StatefulWidget {
  final News news;
  final bool showPicture;
  final bool showSummary;
  final bool isSubCard;

  CardBase({
    Key key,
    @required this.news,
    this.showPicture = true,
    this.showSummary = true,
    this.isSubCard = false,
  }) : super(key: key);

  @override
  _CardBaseState createState() => _CardBaseState();
}

class _CardBaseState extends State<CardBase> {
  News _news;
  bool _isBookmarked;
  UserAction _userAction;
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
    _userAction = _news.userAction;
  }

  void _goToLink(BuildContext context) async {
    ExtendedNavigator.of(context).push(Routes.viewUrl, arguments: ViewUrlArguments(news: _news));
    _userEventBloc.add(ReadNewsEvent(news: _news));
  }

  void _goToQuerySourcePage() {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: _news.source,
        queryField: QueryField.source,
        coverUrl: NewsSource.newsSourceCover[_news.source],
        isShowTitle: true,
      ),
    );
  }

  void _goToQueryCategoryPage() {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        isShowTitle: true,
        query: _news.category,
        queryField: QueryField.category,
        coverUrl: Category.newsCategoryCover[_news.category],
      ),
    );
  }

  void goToQueryTagPage(String tag) {
    final coverUrl = Category.newsCategoryCover.keys.contains(_news.category)
        ? Category.newsCategoryCover[_news.category]
        : Category.newsCategoryCover[Category.localNews];
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: tag,
        queryField: 'tags',
        isShowTitle: true,
        coverUrl: coverUrl,
      ),
    );
  }

  void _onClickLike() {
    _likeNewsBloc.add(LikeNews(news: _news));
  }

  void _onClickBookmark() {
    _saveBookmarkBloc.add(SaveBookmark(news: _news));
  }

  void _setUserAction(UserAction userAction) {
    setState(() {
      _userAction = userAction;
    });
  }

  void _setIsBookmarked(bool isBookmarked) {
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  Widget _buildIcon({Function onPressed, Icon inActive, Icon active, bool isActive, Color activeColor}) {
    final _activeColor = activeColor != null ? activeColor : Theme.of(context).primaryColor;
    return IconButton(
      color: isActive ? _activeColor : Colors.grey,
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
            BotToast.showText(
              text: state.result.isBookmarked ? 'Bookmarked' : 'Removed',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        }),
        BlocListener<LikeNewsBloc, LikeNewsState>(listener: (context, state) {
          if (state is LikeNewsSuccess && state.news.id == _news.id) {
            _setUserAction(state.result.userAction);
          }
        }),
        BlocListener<UserEventBloc, UserEventState>(listener: (context, state) {}),
      ],
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
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
