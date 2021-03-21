import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spent/di/di.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/following/following_bloc.dart';
import 'package:spent/presentation/bloc/manage_following/manage_following_bloc.dart';
import 'package:spent/presentation/helper.dart';
import 'package:spent/presentation/widgets/retry_error.dart';
import 'package:spent/presentation/widgets/section.dart';
import 'package:spent/presentation/widgets/source_icon.dart';

class FollowingPage extends StatefulWidget {
  static final String title = "การติดตาม";

  FollowingPage({Key key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
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

  void _goToFollowingSettingPage(List<Following> followingList, FollowingType followingType) {
    ExtendedNavigator.of(context).push(
      Routes.settingFollowingPage,
      arguments: SettingFollowingPageArguments(followingList: followingList, followingType: followingType),
    );
  }

  Widget _buildSource(String source) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: 100.0,
      height: 90.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: () => goToQuerySourcePage(context, source),
          splashColor: Colors.blue.withAlpha(30),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SourceIcon(source: source),
                Container(height: 8.0),
                Text(
                  source,
                  style: GoogleFonts.kanit(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: 100.0,
      height: 56.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: () => goToQueryTagPage(context, tag),
          splashColor: Colors.blue.withAlpha(30),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                // SourceIcon(source: source),
                // Container(height: 8.0),
                Text(
                  tag,
                  style: GoogleFonts.kanit(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String category) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      width: 100.0,
      height: 56.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          onTap: () => goToQueryCategoryPage(context, category),
          splashColor: Colors.blue.withAlpha(30),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                // SourceIcon(source: source),
                // Container(height: 8.0),
                Text(
                  category,
                  style: GoogleFonts.kanit(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSources(List<Following> followingList) => Section(
      title: 'แหล่งข่าว',
      hasSeeMore: false,
      action: _buildSectionAction(followingList, FollowingType.SOURCE),
      margin: EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Wrap(
            spacing: 8.0,
            runSpacing: 12.0,
            children:
                followingList.where((e) => e.type == FollowingType.SOURCE).map((f) => _buildSource(f.name)).toList(),
          )
        ],
      ));

  Widget _buildTopics(List<Following> followingList) {
    final _curList = followingList.where((e) => e.type == FollowingType.TAG || e.type == FollowingType.CATEGORY);
    return _curList.isEmpty
        ? Container()
        : Section(
            title: 'หัวข้อ',
            hasSeeMore: false,
            action: _buildSectionAction(followingList, FollowingType.TAG),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Wrap(
                  spacing: 8.0,
                  runSpacing: 12.0,
                  children: _curList
                      .map((f) => f.type == FollowingType.TAG ? _buildTag(f.name) : _buildCategory(f.name))
                      .toList(),
                ),
              ],
            ));
  }

  Widget _buildSectionAction(List<Following> followingList, FollowingType followingType) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Colors.grey,
      ),
      onPressed: () => _goToFollowingSettingPage(followingList, followingType),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(FollowingPage.title,
            style: GoogleFonts.kanit(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            )),
        // actions: [IconButton(icon: Icon(Icons.settings, color: Colors.grey), onPressed: _goToFollowingSettingPage)],
      ),
      backgroundColor: Colors.grey[100],
      body: BlocProvider<FollowingBloc>(
        create: (BuildContext context) => _followingBloc,
        child: BlocListener<ManageFollowingBloc, ManageFollowingState>(
          listener: (context, state) {
            if (state is SaveFollowingSuccess || state is SaveFollowingListSuccess) {
              _refreshFollowingList();
            } else if (state is DeleteFollowingSuccess) {
              _followingBloc.add(RemoveFollowingFromList(state.following));
              BotToast.showText(
                text: 'ลบเสร็จสิ้น',
                textStyle: GoogleFonts.kanit(color: Colors.white),
              );
            }
          },
          child: BlocBuilder<FollowingBloc, FollowingState>(
            builder: (context, state) {
              if (state is FollowingInitial || state is FollowingLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FollowingListLoaded) {
                return ListView(
                  children: [
                    _buildSources(state.followingList),
                    _buildTopics(state.followingList),
                  ],
                );
              } else {
                return RetryError(callback: _refreshFollowingList);
              }
            },
          ),
        ),
      ),
    );
  }
}
