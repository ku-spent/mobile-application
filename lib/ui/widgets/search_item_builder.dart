import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:spent/model/search_result.dart';

class SearchItemBuilder extends StatelessWidget {
  const SearchItemBuilder({Key key, SearchResult result}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   final theme = Theme.of(context);
  //   final textTheme = theme.textTheme;

  //   // final model = Provider.of<SearchModel>(context, listen: false);

  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           FloatingSearchBar.of(context).close();
  //           Future.delayed(
  //             const Duration(milliseconds: 500),
  //             // () => model.clear(),
  //           );
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 36,
  //                 child: AnimatedSwitcher(
  //                   duration: const Duration(milliseconds: 500),
  //                   child: model.suggestions == history
  //                       ? const Icon(Icons.history, key: Key('history'))
  //                       : const Icon(Icons.place, key: Key('place')),
  //                 ),
  //               ),
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       place.name,
  //                       style: textTheme.subtitle1,
  //                     ),
  //                     const SizedBox(height: 2),
  //                     Text(
  //                       place.level2Address,
  //                       style: textTheme.bodyText2
  //                           .copyWith(color: Colors.grey.shade600),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       if (model.suggestions.isNotEmpty && place != model.suggestions.last)
  //         const Divider(height: 0),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(),
    );
  }
}
