import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/domain/model/News.dart';
import 'package:spent/domain/model/UserAction.dart';
import 'package:spent/domain/model/UserNewsAction.dart';
import 'package:spent/presentation/bloc/like_news/like_news_bloc.dart';
import 'package:spent/presentation/bloc/manage_bookmark/manage_bookmark_bloc.dart';
import 'package:spent/presentation/bloc/share_news/share_news_bloc.dart';
import 'package:spent/presentation/widgets/clickable_icon.dart';

class WebViewBottom extends StatefulWidget {
  final News news;

  WebViewBottom({Key key, @required this.news}) : super(key: key);

  @override
  _WebViewBottomState createState() => _WebViewBottomState();
}

class _WebViewBottomState extends State<WebViewBottom> {
  News _news;
  bool _isBookmarked;
  UserAction _userAction;

  LikeNewsBloc _likeNewsBloc;
  ShareNewsBloc _shareNewsBloc;
  ManageBookmarkBloc _manageBookmarkBloc;

  @override
  void initState() {
    super.initState();
    _news = widget.news;
    _likeNewsBloc = BlocProvider.of<LikeNewsBloc>(context);
    _shareNewsBloc = BlocProvider.of<ShareNewsBloc>(context);
    _manageBookmarkBloc = BlocProvider.of<ManageBookmarkBloc>(context);
    _isBookmarked = _news.isBookmarked;
    _userAction = _news.userAction;
  }

  void _onClickLike() {
    _likeNewsBloc.add(LikeNews(news: _news));
  }

  void _onClickBookmark() {
    if (_isBookmarked)
      _manageBookmarkBloc.add(DeleteBookmark(news: _news));
    else
      _manageBookmarkBloc.add(SaveBookmark(news: _news));
  }

  void _onClickShare() async {
    _shareNewsBloc.add(ShareNews(context: context, news: _news));
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

  @override
  Widget build(BuildContext context) {
    Widget _buildIcon({Function onPressed, Icon inActive, Icon active, bool isActive}) {
      return IconButton(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        onPressed: onPressed,
        icon: isActive ? active : inActive,
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<ManageBookmarkBloc, ManageBookmarkState>(listener: (context, state) {
          if (state is SaveBookmarkSuccess && state.news.id == _news.id) {
            _setIsBookmarked(true);
            BotToast.showText(
              text: 'Bookmarked',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          } else if (state is DeleteBookmarkSuccess && state.news.id == _news.id) {
            _setIsBookmarked(false);
            BotToast.showText(
              text: 'Removed',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        }),
        BlocListener<LikeNewsBloc, LikeNewsState>(listener: (context, state) {
          if (state is LikeNewsSuccess && state.news.id == _news.id) {
            _setUserAction(state.result.userAction);
          }
        }),
      ],
      child: BottomAppBar(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(width: 1, color: Theme.of(context).dividerColor))),
          height: 48.0,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClickableIcon(
                  isActive: _userAction == UserAction.LIKE,
                  active: Icon(Icons.favorite),
                  inActive: Icon(Icons.favorite_outline),
                  onPressed: _onClickLike,
                  activeColor: Colors.red[400],
                ),
                Container(width: 12.0),
                ClickableIcon(
                  isActive: _isBookmarked,
                  active: Icon(Icons.bookmark),
                  inActive: Icon(Icons.bookmark_outline),
                  onPressed: _onClickBookmark,
                ),
                Container(width: 12.0),
                ClickableIcon(
                  active: Icon(Icons.share),
                  inActive: Icon(Icons.share),
                  onPressed: _onClickShare,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
