import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class FontSize {
  static final String defaultSize = 'default';
  static final String largeSize = 'large';
}

class SettingFontSize extends StatefulWidget {
  SettingFontSize({Key key}) : super(key: key);

  @override
  _SettingFontSizeState createState() => _SettingFontSizeState();
}

class _SettingFontSizeState extends State<SettingFontSize> {
  String _selected = FontSize.defaultSize;

  final List<S2Choice<String>> choices = [
    S2Choice<String>(value: FontSize.defaultSize, title: "default"),
    S2Choice<String>(value: FontSize.largeSize, title: "large"),
  ];

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      title: 'Fruit',
      value: _selected,
      onChange: (selected) => setState(() => _selected = selected.value),
      choiceItems: choices,
      modalType: S2ModalType.popupDialog,
      modalHeader: false,
    );
  }
}

// Future<void> _askedToLead(BuildContext context) async {
//   switch (await showDialog<Department>(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Select assignment'),
//           children: <Widget>[
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, Department.treasury);
//               },
//               child: const Text('Treasury department'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, Department.state);
//               },
//               child: const Text('State department'),
//             ),
//           ],
//         );
//       })) {
//     case Department.treasury:
//       // Let's go.
//       // ...
//       break;
//     case Department.state:
//       // ...
//       break;
//     case null:
//       // dialog dismissed
//       break;
//   }
// }
