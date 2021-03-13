import 'package:flutter/material.dart';
import 'package:spent/domain/model/BlockTypes.dart';
import 'package:spent/domain/model/Choice.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';

class QueryPageSetting extends StatefulWidget {
  final QueryObject query;
  final void Function(QueryPageBlockChoice choice) onSelected;

  QueryPageSetting({Key key, @required this.query, @required this.onSelected}) : super(key: key);

  @override
  QueryPageSettingState createState() => QueryPageSettingState();
}

class QueryPageSettingState extends State<QueryPageSetting> {
  QueryPageBlockChoice _buildChoices() {
    final _query = widget.query;
    if (_query is QueryWithField) {
      switch (_query.queryField) {
        case QueryField.category:
          return QueryPageBlockChoice(title: QueryPageOptions.category, name: _query.query, type: BlockTypes.CATEGORY);
        case QueryField.source:
          return QueryPageBlockChoice(title: QueryPageOptions.source, name: _query.query, type: BlockTypes.SOURCE);
        case QueryField.tags:
          return QueryPageBlockChoice(title: QueryPageOptions.tag, name: _query.query, type: BlockTypes.TAG);
        default:
          throw Exception("Not found QueryField type");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: widget.onSelected,
      itemBuilder: (BuildContext context) {
        return [_buildChoices()]
            .map((choice) => PopupMenuItem(
                value: choice,
                child: Row(
                  children: [
                    QueryPageOptions.icon,
                    Container(
                      width: 16,
                    ),
                    Text(choice.title)
                  ],
                )))
            .toList();
      },
    );
  }
}

class QueryPageBlockChoice extends BlockChoice {
  final String title;
  QueryPageBlockChoice({this.title, String name, BlockTypes type}) : super(name: name, type: type);
}

class QueryPageOptions {
  static const String source = "ซ่อนเนื้อหาจากแหล่งข่าวนี้";
  static const String category = "ซ่อนเนื้อหาประเภทนี้";
  static const String tag = "ซ่อนเนื้อหาประเภทนี้";

  static const icon = Icon(Icons.block, size: 24, color: Colors.black54);
}
