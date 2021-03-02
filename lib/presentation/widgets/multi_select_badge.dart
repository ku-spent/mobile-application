import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spent/domain/model/Choice.dart';

class MutiSelectBadge<T extends Choice> extends StatefulWidget {
  final List<T> list;
  final void Function(List<T>) onChange;

  MutiSelectBadge({Key key, @required this.list, this.onChange}) : super(key: key);

  @override
  _MutiSelectBadgeState createState() => _MutiSelectBadgeState<T>();
}

class _MutiSelectBadgeState<T extends Choice> extends State<MutiSelectBadge> {
  final List<T> selectedItems = [];

  List<Widget> _buildChoiceList() {
    return widget.list
        .map(
          (item) => Container(
            child: ChoiceChip(
              pressElevation: 0,
              shape: StadiumBorder(
                  side: BorderSide(
                      color: selectedItems.contains(item) ? Theme.of(context).primaryColorLight : Colors.grey[300])),
              selected: selectedItems.contains(item),
              selectedColor: Theme.of(context).primaryColorLight,
              backgroundColor: Colors.white,
              label: Text(
                item.title,
                style: GoogleFonts.kanit(
                    color: selectedItems.contains(item) ? Theme.of(context).primaryColor : Colors.black87),
              ),
              onSelected: (selected) {
                setState(() {
                  selectedItems.contains(item) ? selectedItems.remove(item) : selectedItems.add(item);
                });
                if (widget.onChange != null) {
                  widget.onChange(selectedItems);
                }
              },
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      children: _buildChoiceList(),
    );
  }
}
