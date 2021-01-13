import 'package:flutter/material.dart';
import 'package:spent/domain/model/search_item.dart';

typedef OnClick = void Function(String query);

class SearchItemBuilder extends StatelessWidget {
  final SearchItem result;
  final OnClick onClick;

  const SearchItemBuilder({Key key, this.result, this.onClick}) : super(key: key);

  Icon _buildIconType(String type) {
    if (type == SearchItem.category)
      return Icon(Icons.category);
    // else if (type == SearchItem.news)
    //   return Icon(Icons.fiber_new_rounded);
    else if (type == SearchItem.source) return Icon(Icons.rss_feed);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => {onClick(result.value)},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _buildIconType(result.type),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.value,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        result.description,
                        style: Theme.of(context).textTheme.caption.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // if (model.suggestions.isNotEmpty && place != model.suggestions.last)
        Divider(height: 16.0),
      ],
    );
  }
}
