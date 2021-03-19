import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/presentation/bloc/following/following_bloc.dart';
import 'package:spent/presentation/bloc/manage_following/manage_following_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
import 'package:spent/presentation/widgets/clickable_animation.dart';

class QueryPageFollowing extends StatefulWidget {
  final QueryObject query;

  QueryPageFollowing({Key key, @required this.query}) : super(key: key);

  @override
  _QueryPageFollowingState createState() => _QueryPageFollowingState();
}

class _QueryPageFollowingState extends State<QueryPageFollowing> {
  Following _following;
  QueryObject _query;
  String _name;
  FollowingType _followingType;
  FollowingBloc _followingBloc;
  ManageFollowingBloc _manageFollowingBloc;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _query = widget.query;
    if (_query is QueryWithField) {
      final String _queryField = (_query as QueryWithField).queryField;
      switch (_queryField) {
        case QueryField.source:
          _followingType = FollowingType.SOURCE;
          break;
        case QueryField.tags:
          _followingType = FollowingType.TAG;
          break;
        case QueryField.category:
          _followingType = FollowingType.CATEGORY;
          break;
        default:
          _followingType = FollowingType.SOURCE;
          break;
      }
      print(_followingType);
      _manageFollowingBloc = BlocProvider.of<ManageFollowingBloc>(context);
      _followingBloc = getIt<FollowingBloc>()..add(FetchFollowing(_query.title, _followingType));
      _name = _query.title;
    }
  }

  @override
  void dispose() {
    _followingBloc.close();
    super.dispose();
  }

  void _setIsFollowing(bool isFollowing) {
    setState(() {
      _isFollowing = isFollowing;
    });
  }

  void _setFollowing(Following following) {
    setState(() {
      _following = following;
    });
  }

  void _onTap() {
    if (_isFollowing && _following != null) {
      _manageFollowingBloc.add(DeleteFollowing(_following));
    } else {
      _manageFollowingBloc.add(AddFollowing(_name, _followingType));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_query is QueryWithField) {
      return BlocProvider<FollowingBloc>(
        create: (BuildContext context) => _followingBloc,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ManageFollowingBloc, ManageFollowingState>(listener: (context, state) {
              if (state is SaveFollowingSuccess) {
                _setIsFollowing(true);
                _setFollowing(state.following);
                BotToast.showText(
                  text: 'คุณได้ติดตาม ${state.following.name}',
                  textStyle: GoogleFonts.kanit(color: Colors.white),
                );
              } else if (state is DeleteFollowingSuccess) {
                _setIsFollowing(false);
                _setFollowing(null);
                BotToast.showText(
                  text: 'ยกเลิกการติดตาม',
                  textStyle: GoogleFonts.kanit(color: Colors.white),
                );
              }
            }),
            BlocListener<FollowingBloc, FollowingState>(listener: (context, state) {
              if (state is FollowingLoaded) {
                _setIsFollowing(state.following != null);
                _setFollowing(state.following);
              }
            }),
          ],
          child: ClickableAnimation(
            active: Icons.star,
            inActive: Icons.star,
            onPressed: _onTap,
            isActive: _isFollowing,
          ),
        ),
      );
    } else {
      return null;
    }
  }
}
