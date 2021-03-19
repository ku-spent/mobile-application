import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/di/di.dart';
import 'package:spent/domain/model/Following.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/following/following_bloc.dart';
// import 'package:spent/presentation/bloc/following/following_bloc.dart'
import 'package:spent/presentation/bloc/manage_following/manage_following_bloc.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';
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

  void _goToQuerySourcePage(String source) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
        query: QueryWithField(source, query: source, queryField: QueryField.source),
        coverUrl: NewsSource.newsSourceCover[source],
        isShowTitle: true,
      ),
    );
  }

  void _goToFollowingSettingPage() {
    ExtendedNavigator.of(context).push(
      Routes.settingFollowingPage,
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
          onTap: () => _goToQuerySourcePage(source),
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

  Widget _buildSources(List<Following> followingList) => Section(
      title: 'แหล่งข่าว',
      hasSeeMore: false,
      margin: EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(children: followingList.map((f) => _buildSource(f.name)).toList()),
            ),
          ),
        ],
      ));

  void _goToQueryTagPage(String tag) {
    ExtendedNavigator.of(context).push(
      Routes.queryPage,
      arguments: QueryPageArguments(
          query: QueryWithField(tag, query: tag, queryField: QueryField.tags),
          isShowTitle: true,
          coverUrl: Category.newsCategoryCover[Category.localNews]),
    );
  }

  Widget _buildTag(String category) {
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
          onTap: () => _goToQueryTagPage(category),
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

  Widget _buildTags(List<Following> followingList) => Section(
      title: 'หัวข้อ',
      hasSeeMore: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(children: followingList.map((f) => _buildTag(f.name)).toList()),
            ),
          ),
        ],
      ));

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(FollowingPage.title,
            style: GoogleFonts.kanit(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 24.0,
            )),
        actions: [IconButton(icon: Icon(Icons.settings, color: Colors.grey), onPressed: _goToFollowingSettingPage)],
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
                final sourceList = state.followingList.where((e) => e.type == FollowingType.SOURCE).toList();
                final tagList = state.followingList.where((e) => e.type == FollowingType.TAG).toList();
                return ListView(
                  children: [
                    _buildSources(sourceList),
                    tagList.isNotEmpty ? _buildTags(tagList) : Container(),
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
