import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/model/search_result.dart';
// import 'package:spent/ui/widgets/search_item_builder.dart';

typedef Widget DisplayBody();

class SearchBar extends StatefulWidget {
  final DisplayBody widget;
  SearchBar({Key key, this.widget}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  DisplayBody _widget;
  final controller = FloatingSearchBarController();

  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? controller.hide() : controller.show();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _widget = widget.widget;
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.fiber_new_sharp),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final SearchResult result = SearchResult(name: 'test', type: 'test');

    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
      return FloatingSearchBar(
        controller: controller,
        clearQueryOnClose: true,
        hint: 'Search for a news...',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        maxWidth: isPortrait ? 600 : 500,
        actions: actions,
        // progress: model.isLoading,
        debounceDelay: const Duration(milliseconds: 500),
        // onQueryChanged: model.onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(),
        builder: (context, _) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        ),
        // SearchItemBuilder(
        //   result: result,
        // ),
      );
    });
  }
}
