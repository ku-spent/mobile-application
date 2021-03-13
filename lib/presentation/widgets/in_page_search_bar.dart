import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class InPageSearchBar extends StatefulWidget {
  final Widget body;
  final String title;
  final String hint;
  final void Function(String) onQueryChanged;
  final void Function(String) onSubmitted;

  InPageSearchBar({
    Key key,
    this.body,
    this.onSubmitted,
    this.hint,
    this.onQueryChanged,
    this.title,
  }) : super(key: key);

  @override
  _InPageSearchBarState createState() => _InPageSearchBarState();
}

class _InPageSearchBarState extends State<InPageSearchBar> {
  bool _isKeyboardVisibility = false;
  FloatingSearchBarController _controller;
  KeyboardVisibilityController _keyboardVisibilityController;
  StreamSubscription<bool> _keyboardVisibilitySubscription;
  @override
  void initState() {
    super.initState();

    _controller = FloatingSearchBarController();
    _keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardVisibilitySubscription = _keyboardVisibilityController.onChange.listen((bool visible) {
      print('visible changed to $visible');
      if (!visible && _isKeyboardVisibility) {
        _controller.close();
      }
      setState(() {
        _isKeyboardVisibility = visible;
      });
    });
  }

  @override
  void dispose() {
    _keyboardVisibilitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
      title: Text(widget.title, style: GoogleFonts.kanit()),
      hint: widget.hint,
      elevation: 1,
      controller: _controller,
      clearQueryOnClose: false,
      hintStyle: GoogleFonts.kanit(),
      iconColor: Colors.grey,
      colorOnScroll: Colors.white,
      transitionCurve: Curves.easeInOutCubic,
      transitionDuration: const Duration(milliseconds: 300),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      automaticallyImplyDrawerHamburger: false,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: widget.onQueryChanged,
      onSubmitted: widget.onSubmitted,
      body: widget.body,
    );
  }
}
