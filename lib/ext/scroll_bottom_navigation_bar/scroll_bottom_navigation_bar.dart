import 'package:flutter/material.dart';

import 'scroll_bottom_navigation_bar_controller.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  final ScrollController controller;
  final double elevation;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final MaterialType materialType;
  final Widget child;

  ScrollBottomNavigationBar({
    Key key,
    @required this.controller,
    @required this.child,
    this.elevation = 8.0,
    this.backgroundColor = Colors.transparent,
    this.materialType,
    this.backgroundGradient,
  })  : assert(controller != null),
        super(key: key);

  @override
  _ScrollBottomNavigationBarState createState() => _ScrollBottomNavigationBarState();
}

class _ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar> {
  Widget bottomNavigationBar;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (widget.backgroundGradient == null) {
      backgroundColor = widget.backgroundColor ?? Theme.of(context).canvasColor ?? Colors.white;
    }

    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.bottomNavigationBar.tabNotifier,
      builder: _tab,
    );
  }

  Widget _tab(BuildContext context, int _, Widget __) {
    bottomNavigationBar = widget.child;
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.bottomNavigationBar.pinNotifier,
      builder: _pin,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget child) {
    if (isPinned) return _align(1.0);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.bottomNavigationBar.heightNotifier,
      builder: _height,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height);
  }

  Widget _align(double heightFactor) {
    return Align(
      heightFactor: heightFactor,
      alignment: Alignment(0, -1),
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: widget.elevation,
      type: widget.materialType != null ? widget.materialType : MaterialType.canvas,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.controller.bottomNavigationBar.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: heightFactor,
      child: bottomNavigationBar,
    );
  }
}
