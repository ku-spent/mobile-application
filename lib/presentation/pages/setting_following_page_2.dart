import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import 'package:spent/di/di.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/presentation/widgets/list_item.dart';
import 'package:spent/presentation/widgets/retry_error.dart';
import 'package:spent/presentation/bloc/following/following_bloc.dart';
import 'package:spent/presentation/bloc/manage_following/manage_following_bloc.dart';

class SettingFollowingPage extends StatefulWidget {
  static final String title = "การติดตาม";

  SettingFollowingPage({Key key}) : super(key: key);

  @override
  _SettingFollowingPageState createState() => _SettingFollowingPageState();
}

class _SettingFollowingPageState extends State<SettingFollowingPage> {
  FollowingBloc _followingBloc;
  ManageFollowingBloc _manageFollowingBloc;

  @override
  void initState() {
    super.initState();
    _manageFollowingBloc = BlocProvider.of<ManageFollowingBloc>(context);
    _followingBloc = getIt<FollowingBloc>()..add(FetchFollowingList());
  }

  void _refreshFollowingList() {
    _followingBloc.add(RefreshFollowingList());
  }

  void _onDeleteFollowing(Following following) {
    _manageFollowingBloc.add(DeleteFollowing(following));
  }

  Widget _buildBox(Following item, double t) {
    final elevation = lerpDouble(0, 8, t);
    final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      child: Material(
        color: color,
        elevation: elevation,
        type: MaterialType.transparency,
        child: ListItem(
          leading: item.type == FollowingType.SOURCE ? Icon(Icons.rss_feed) : Icon(Icons.category),
          trailing: Handle(
            delay: const Duration(milliseconds: 100),
            child: Icon(
              Icons.list,
              color: Colors.grey,
            ),
          ),
          title: Text(item.name),
          onTap: () => {},
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _onDeleteFollowing(item),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title: Text(SettingFollowingPage.title,
            style: GoogleFonts.kanit(
              color: Colors.black87,
              // fontWeight: FontWeight.w500,
              // fontSize: 24.0,
            )),
      ),
      backgroundColor: Colors.grey[100],
      body: BlocProvider<FollowingBloc>(
        create: (BuildContext context) => _followingBloc,
        child: BlocListener<ManageFollowingBloc, ManageFollowingState>(
          listener: (context, state) {
            if (state is SaveFollowingSuccess) {
              _refreshFollowingList();
            } else if (state is DeleteFollowingSuccess) {
              _followingBloc.add(RemoveFollowingFromList(state.following));
              BotToast.showText(
                text: 'ลบเสร็จสิ้น',
                textStyle: GoogleFonts.kanit(color: Colors.white),
              );
            }
          },
          child: BlocBuilder<FollowingBloc, FollowingState>(builder: (context, state) {
            if (state is FollowingInitial || state is FollowingLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FollowingListLoaded) {
              return ImplicitlyAnimatedReorderableList<Following>(
                padding: const EdgeInsets.only(top: 8.0),
                physics: const NeverScrollableScrollPhysics(),
                items: state.followingList,
                areItemsTheSame: (a, b) => a == b,
                onReorderFinished: (item, from, to, newItems) {
                  Function eq = const ListEquality().equals;
                  if (!eq(state.followingList, newItems)) {
                    _manageFollowingBloc.add(SaveFollowingList(newItems));
                  }
                },
                itemBuilder: (context, itemAnimation, item, index) {
                  return Reorderable(
                    key: ValueKey(item.id),
                    builder: (context, dragAnimation, inDrag) {
                      final t = dragAnimation.value;
                      return SizeFadeTransition(
                        sizeFraction: 0.7,
                        curve: Curves.easeInOut,
                        animation: itemAnimation,
                        child: _buildBox(item, t),
                      );
                    },
                  );
                },
                updateItemBuilder: (context, itemAnimation, item) {
                  return Reorderable(
                    key: ValueKey(item.id),
                    child: FadeTransition(
                      opacity: itemAnimation,
                      child: _buildBox(item, 0),
                    ),
                  );
                },
              );
            } else {
              return RetryError(callback: _refreshFollowingList);
            }
          }),
        ),
      ),
    );
  }
}
