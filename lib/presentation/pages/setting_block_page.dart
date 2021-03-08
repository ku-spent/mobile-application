import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/block/block_bloc.dart';
import 'package:spent/presentation/bloc/manage_block/manage_block_bloc.dart';
import 'package:spent/presentation/widgets/in_page_search_bar.dart';
import 'package:spent/presentation/widgets/retry_error.dart';

class SettingBlockPage extends StatefulWidget {
  static String title = 'การซ่อนแหล่งข่าว & หัวข้อ';

  final ScrollController scrollController = ScrollController();

  SettingBlockPage({Key key}) : super(key: key);

  @override
  _SettingBlockPageState createState() => _SettingBlockPageState();
}

class _SettingBlockPageState extends State<SettingBlockPage> {
  String _query = '';
  BlockBloc _historyBloc;
  ManageBlockBloc _manageBlockBloc;
  ScrollController _scrollController;

  final _scrollThreshold = 200.0;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController;
    _scrollController.addListener(_onScroll);
    Future.delayed(Duration.zero, () async {
      _historyBloc = BlocProvider.of<BlockBloc>(context);
      _manageBlockBloc = BlocProvider.of<ManageBlockBloc>(context);
      _refreshBlocks();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if ((maxScroll - currentScroll) > 0 && (maxScroll - currentScroll <= _scrollThreshold)) {
      _fetchHistories();
    }
  }

  void _fetchHistories() {
    _historyBloc.add(FetchBlock(query: _query));
  }

  void _refreshBlocks() {
    _historyBloc.add(RefreshBlock(query: _query));
  }

  void _onRefresh() async {
    _historyBloc.add(RefreshBlock(query: _query, callback: _refreshController.refreshCompleted));
  }

  void _onDelete(Block block) async {
    _manageBlockBloc.add(DeleteBlock(block: block));
  }

  void _onQueryChanged(String query) {
    setState(() {
      _query = query;
    });
    _refreshBlocks();
  }

  Icon _buildIconType(BlockTypes type) {
    if (type == BlockTypes.CATEGORY || type == BlockTypes.TAG)
      return Icon(Icons.category);
    else if (type == BlockTypes.SOURCE) return Icon(Icons.rss_feed);
    return null;
  }

  Widget _buildItem(BuildContext context, Block block) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Slidable(
        actionPane: const SlidableBehindActionPane(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 16.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 36,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: _buildIconType(block.type),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            block.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            block.type == BlockTypes.SOURCE ? 'แหล่งข่าว' : 'หัวข้อ',
                            style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0.0),
          ],
        ),
        secondaryActions: [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => _onDelete(block),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ManageBlockBloc, ManageBlockState>(
        listener: (context, state) {
          if (state is SaveBlockSuccess) {
            _refreshBlocks();
          } else if (state is DeleteBlockSuccess) {
            _historyBloc.add(RemoveBlockFromList(block: state.block));
            BotToast.showText(
              text: 'ลบเสร็จสิ้น',
              textStyle: GoogleFonts.kanit(color: Colors.white),
            );
          }
        },
        child: BlocBuilder<BlockBloc, BlockState>(
          builder: (context, state) {
            if (state is BlockInitial || state is BlockLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BlockLoaded) {
              return InPageSearchBar(
                title: SettingBlockPage.title,
                hint: 'ค้นหา',
                onQueryChanged: _onQueryChanged,
                onSubmitted: _onQueryChanged,
                body: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: state.hasMore,
                  header: WaterDropMaterialHeader(),
                  physics: BouncingScrollPhysics(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      state.blocks.isEmpty ? Center(child: Text('no history.')) : Container(),
                      ImplicitlyAnimatedList<Block>(
                        shrinkWrap: true,
                        items: state.blocks,
                        physics: const NeverScrollableScrollPhysics(),
                        removeDuration: const Duration(milliseconds: 100),
                        insertDuration: const Duration(milliseconds: 100),
                        updateDuration: const Duration(milliseconds: 100),
                        areItemsTheSame: (a, b) => a.id == b.id,
                        itemBuilder: (context, animation, result, i) {
                          return SizeFadeTransition(
                            key: ValueKey(result.id),
                            animation: animation,
                            child: _buildItem(context, result),
                          );
                        },
                        updateItemBuilder: (context, animation, result) {
                          return FadeTransition(
                            key: ValueKey(result.id),
                            opacity: animation,
                            child: _buildItem(context, result),
                          );
                        },
                        removeItemBuilder: (context, animation, result) {
                          return FadeTransition(
                            key: ValueKey(result.id),
                            opacity: animation,
                            child: _buildItem(context, result),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is BlockLoadError) {
              return RetryError(callback: _onRefresh);
            }
          },
        ),
      ),
      // ),
    );
  }
}
