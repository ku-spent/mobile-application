import 'package:flutter/material.dart';

class ClickableIcon extends StatelessWidget {
  final Icon inActive;
  final Icon active;
  final Color activeColor;
  final bool isActive;
  final void Function() onPressed;

  const ClickableIcon({
    Key key,
    @required this.inActive,
    @required this.active,
    this.activeColor,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _activeColor = activeColor != null ? activeColor : Theme.of(context).primaryColor;
    return IconButton(
      splashColor: _activeColor.withOpacity(0.2),
      color: isActive ? _activeColor : Colors.grey,
      onPressed: onPressed,
      icon: isActive ? active : inActive,
    );
  }
}
