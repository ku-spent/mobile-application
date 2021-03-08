import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/domain/model/Choice.dart';

import 'package:spent/domain/model/ModelProvider.dart';
import 'package:spent/presentation/bloc/manage_block/manage_block_bloc.dart';
import 'package:spent/presentation/widgets/multi_select_badge.dart';

void showNewsBottomSheet(BuildContext context, News news) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    useRootNavigator: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
    ),
    builder: (BuildContext bc) {
      return NewsBottomSheet(news: news);
    },
  );
}

class NewsBottomSheet extends StatefulWidget {
  final News news;
  NewsBottomSheet({Key key, @required this.news}) : super(key: key);

  @override
  _NewsBottomSheetState createState() => _NewsBottomSheetState();
}

class _NewsBottomSheetState extends State<NewsBottomSheet> {
  bool _isSelectedBlock = false;
  bool _isSelectedSeeLess = false;
  List<BlockChoice> _selectedList = [];
  List<BlockChoice> _topicChoices;
  ManageBlockBloc _manageBlockBloc;

  @override
  void initState() {
    super.initState();
    _manageBlockBloc = BlocProvider.of<ManageBlockBloc>(context);
    _topicChoices = [BlockChoice(name: widget.news.category, type: BlockTypes.CATEGORY)] +
        widget.news.tags.map((tag) => BlockChoice(name: tag, type: BlockTypes.TAG)).toList();
  }

  void onMultiSelectChange(List<Choice> selectedList) {
    setState(() {
      _selectedList = selectedList;
    });
  }

  void onClickBlock() {
    setState(() {
      _isSelectedBlock = !_isSelectedBlock;
    });
  }

  void onClickSeeLess() {
    setState(() {
      _isSelectedSeeLess = !_isSelectedSeeLess;
    });
  }

  void onDone() {
    print('Done');
    final List<BlockChoice> sourceBlock =
        _isSelectedBlock ? [BlockChoice(name: widget.news.source, type: BlockTypes.SOURCE)] : [];
    _manageBlockBloc.add(SaveBlock(blockChoices: _selectedList + sourceBlock));
    BotToast.showText(
      text: 'คุณจะเห็นข่าวที่คล้ายกันน้อยลง',
      textStyle: GoogleFonts.kanit(color: Colors.white),
    );
    Navigator.pop(context);
  }

  bool canDone() => !_isSelectedSeeLess || (_isSelectedSeeLess && _selectedList.isNotEmpty);

  Widget _buildListTile({String title, IconData icon, bool isSelected, void Function() onTap}) {
    return ListTile(
      leading: isSelected ? Icon(Icons.check_circle, color: Colors.green[400]) : Icon(icon),
      trailing: isSelected
          ? Text('เลิกทำ', style: GoogleFonts.kanit(color: Theme.of(context).primaryColor, fontSize: 16.0))
          : null,
      title: isSelected ? Text(title, style: GoogleFonts.kanit(color: Colors.grey)) : Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSeeLessDetail() => Container(
        color: Theme.of(context).primaryColor.withOpacity(0.02),
        padding: EdgeInsets.only(left: 16.0, bottom: 12.0, right: 12.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 18.0),
            Text('หัวข้อไหนที่คุณต้องการจะเห็นน้อยลง',
                style: GoogleFonts.kanit(
                  // color: Theme.of(context).primaryColor,
                  fontSize: 22.0,
                )),
            Container(height: 12.0),
            MutiSelectBadge<BlockChoice>(
              list: _topicChoices,
              onChange: onMultiSelectChange,
            )
          ],
        ),
      );

  Widget _buildConfirm() {
    final bool _canDone = canDone();
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
                child: Text('ยกเลิก',
                    style: GoogleFonts.kanit(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                    )),
              )),
          Container(width: 16.0),
          TextButton(
            onPressed: _canDone ? onDone : null,
            child: Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0, bottom: 4.0),
              child: Text('เสร็จสิ้น',
                  style: GoogleFonts.kanit(
                    color: _canDone ? Theme.of(context).primaryColor : Colors.grey,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageBlockBloc, ManageBlockState>(
      listener: (context, state) {},
      child: Container(
        child: Wrap(
          children: <Widget>[
            _buildListTile(
              icon: Icons.block_flipped,
              title: 'ซ่อนข่าวจาก ${widget.news.source}',
              isSelected: _isSelectedBlock,
              onTap: onClickBlock,
            ),
            _buildListTile(
              icon: Icons.remove_circle_outline,
              title: 'ซ่อนโพสต์',
              isSelected: _isSelectedSeeLess,
              onTap: onClickSeeLess,
            ),
            _isSelectedSeeLess ? _buildSeeLessDetail() : Container(),
            _buildConfirm(),
          ],
        ),
      ),
    );
  }
}
