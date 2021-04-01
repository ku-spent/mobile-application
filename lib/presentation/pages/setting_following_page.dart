import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

import 'package:spent/domain/model/Following.dart';
import 'package:spent/presentation/helper.dart';
import 'package:spent/presentation/widgets/list_item.dart';
import 'package:spent/presentation/bloc/manage_following/manage_following_bloc.dart';
import 'package:spent/presentation/widgets/no_result.dart';
import 'package:spent/presentation/widgets/source_icon.dart';

class SettingFollowingPage extends StatefulWidget {
  final List<Following> followingList;
  final FollowingType followingType;

  SettingFollowingPage({Key key, @required this.followingList, @required this.followingType}) : super(key: key);

  @override
  _SettingFollowingPageState createState() => _SettingFollowingPageState();
}

class _SettingFollowingPageState extends State<SettingFollowingPage> {
  // FollowingBloc _followingBloc;
  ManageFollowingBloc _manageFollowingBloc;
  List<Following> _otherFollowingList;
  List<Following> _curFollowingList;

  @override
  void initState() {
    super.initState();
    _manageFollowingBloc = BlocProvider.of<ManageFollowingBloc>(context);
    final followingSourceList = widget.followingList.where((e) => e.type == FollowingType.SOURCE).toList();
    final followingTopicList =
        widget.followingList.where((e) => e.type == FollowingType.TAG || e.type == FollowingType.CATEGORY).toList();
    if (widget.followingType == FollowingType.SOURCE) {
      _curFollowingList = followingSourceList;
      _otherFollowingList = followingTopicList;
    } else {
      _curFollowingList = followingTopicList;
      _otherFollowingList = followingSourceList;
    }
  }

  void _onDeleteFollowing(Following following) {
    _manageFollowingBloc.add(DeleteFollowing(following));
  }

  Widget _buildBox(Following item, double t) {
    final elevation = lerpDouble(0, 8, t);
    final color = Color.lerp(Colors.white, Colors.white.withOpacity(0.8), t);
    Function onTap;

    switch (item.type) {
      case FollowingType.SOURCE:
        onTap = goToQuerySourcePage;
        break;
      case FollowingType.CATEGORY:
        onTap = goToQueryCategoryPage;
        break;
      case FollowingType.TAG:
        onTap = goToQueryTagPage;
        break;
      default:
    }

    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      child: Material(
        color: color,
        elevation: elevation,
        type: MaterialType.transparency,
        child: ListItem(
          leading: item.type == FollowingType.SOURCE ? SourceIcon(source: item.name) : Icon(Icons.category),
          trailing: Handle(
            delay: const Duration(milliseconds: 100),
            child: Icon(
              Icons.list,
              color: Colors.grey,
            ),
          ),
          title: Text(item.name),
          onTap: () => onTap(context, item.name),
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
        title: Text(widget.followingType == FollowingType.SOURCE ? 'แหล่งข่าว' : 'หัวข้อ',
            style: GoogleFonts.kanit(
              color: Colors.black87,
            )),
      ),
      backgroundColor: Colors.grey[100],
      body: BlocListener<ManageFollowingBloc, ManageFollowingState>(
        listener: (context, state) {
          if (state is DeleteFollowingSuccess) {
            setState(() {
              _curFollowingList = _curFollowingList.where((e) => e != state.following).toList();
            });
            BotToast.showText(
              text: 'ลบเสร็จสิ้น',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        },
        child: Column(
          children: [
            _curFollowingList.isEmpty ? NoResult() : Container(),
            Expanded(
              child: ImplicitlyAnimatedReorderableList<Following>(
                  padding: const EdgeInsets.only(top: 8.0),
                  physics: const NeverScrollableScrollPhysics(),
                  items: _curFollowingList,
                  areItemsTheSame: (a, b) => a == b,
                  onReorderFinished: (item, from, to, newItems) {
                    Function eq = const ListEquality().equals;
                    if (!eq(_curFollowingList, newItems)) {
                      setState(() {
                        _curFollowingList = newItems;
                      });
                      _manageFollowingBloc.add(SaveFollowingList(newItems + _otherFollowingList));
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
