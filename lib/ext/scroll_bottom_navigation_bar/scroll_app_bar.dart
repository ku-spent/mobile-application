import 'package:flutter/material.dart';

import 'scroll_app_bar_controller.dart';

class ScrollAppBar extends StatefulWidget with PreferredSizeWidget {
  final ScrollController controller;
  final double elevation;
  final Gradient backgroundGradient;
  final Color backgroundColor;
  final MaterialType materialType;
  final Widget child;

  ScrollAppBar({
    Key key,
    @required this.controller,
    @required this.child,
    this.elevation,
    this.backgroundGradient,
    this.materialType,
    this.backgroundColor,
  })  : assert(controller != null),
        super(key: key);

  @override
  _ScrollAppBarState createState() => _ScrollAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  Widget appBar;
  double elevation;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    appBar = widget.child;

    backgroundColor = widget.backgroundColor ?? Theme.of(context).appBarTheme.color ?? Theme.of(context).primaryColor;

    elevation = widget.elevation ?? Theme.of(context).appBarTheme.elevation ?? 4.0;

    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.appBar.pinNotifier,
      builder: _pin,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget child) {
    if (isPinned) return _align(1.0);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.appBar.heightNotifier,
      builder: _height,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height);
  }

  Widget _align(double heightFactor) {
    return Align(
      alignment: Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: elevation,
      type: widget.materialType != null ? widget.materialType : MaterialType.canvas,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.controller.appBar.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: appBar,
    );
  }
}
