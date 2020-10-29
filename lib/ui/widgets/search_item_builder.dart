import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/bloc/search/search_bloc.dart';
import 'package:spent/model/search_result.dart';

class SearchItemBuilder extends StatelessWidget {
  final String title;
  final List<SearchResult> results;

  const SearchItemBuilder({
    Key key,
    @required this.results,
    @required this.title,
  }) : super(key: key);

  // Icon _buildIconType(ResultType type) {
  //   switch (type) {
  //     case ResultType.news:
  //       return Icon(Icons.fiber_new_sharp);
  //     case ResultType.topic:
  //       return Icon(Icons.topic);
  //     default:
  //       return Icon(Icons.rss_feed);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      results.isEmpty
          ? Container()
          : Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                title,
                style: GoogleFonts.kanit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )),
      ImplicitlyAnimatedList<SearchResult>(
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
            child: buildItem(context, result),
          );
        },
        updateItemBuilder: (context, animation, result) {
          return FadeTransition(
            opacity: animation,
            child: buildItem(context, result),
          );
        },
      ),
    ]);
  }

  Widget buildItem(BuildContext context, SearchResult result) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              FloatingSearchBar.of(context).close();
              Future.delayed(
                const Duration(milliseconds: 500),
                () => {
                  // model.clear()
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // SizedBox(
                  //   width: 36,
                  //   child: AnimatedSwitcher(
                  //     duration: const Duration(milliseconds: 500),
                  //     child: _buildIconType(result.type),
                  //   ),
                  // ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.name,
                          style: textTheme.subtitle1,
                        ),
                        Text(
                          result.name,
                          style: textTheme.bodyText2
                              .copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (model.suggestions.isNotEmpty && place != model.suggestions.last)
          Divider(height: 0),
        ],
      );
    });
  }
}
