import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget title;
  final Widget leading;
  final Widget trailing;
  final void Function() onTap;

  const ListItem({Key key, this.title, this.leading, this.onTap, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        splashColor: Colors.blue.withAlpha(30),
        child: ListTile(
          title: title,
          leading: leading,
          trailing: trailing,
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
        ),
      ),
    );
  }
}
