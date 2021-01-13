import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

typedef OnClick = void Function(String query);

class SearchItemList<T> extends StatelessWidget {
  final String title;
  final List<T> results;
  final Widget Function(T result) itemBuilder;

  const SearchItemList({
    Key key,
    @required this.results,
    @required this.title,
    @required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      results.isEmpty
          ? Container()
          : Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Text(
                title,
                style: GoogleFonts.kanit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )),
      ImplicitlyAnimatedList<T>(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        items: results,
        removeDuration: const Duration(milliseconds: 200),
        insertDuration: const Duration(milliseconds: 200),
        updateDuration: const Duration(milliseconds: 200),
        areItemsTheSame: (a, b) => a == b,
        itemBuilder: (context, animation, result, i) {
          return SizeFadeTransition(
            animation: animation,
            child: itemBuilder(result),
          );
        },
        updateItemBuilder: (context, animation, result) {
          return FadeTransition(
            opacity: animation,
            child: itemBuilder(result),
          );
        },
        removeItemBuilder: (context, animation, result) {
          return FadeTransition(
            opacity: animation,
            child: itemBuilder(result),
          );
        },
      ),
    ]);
  }
}
