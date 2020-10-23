import 'dart:math';

import 'package:spent/model/search_result.dart';

class SearchRepository {
  Future<List<SearchResult>> loadSearchResults() async {
    Random rand = Random();
    int num = rand.nextInt(10) + 1;
    var list = new List<int>.generate(num, (i) => i + 1);
    return Future.delayed(
        const Duration(milliseconds: 500),
        () => list
            .map((e) {
              int num = rand.nextInt(10);
              int num2 = rand.nextInt(3);
              String type = '';
              if (num2 == 1)
                type = 'topic';
              else if (num2 == 0)
                type = 'source';
              else
                type = 'news';
              return {'name': 'testzztest$num', 'type': type};
            })
            .map((e) => SearchResult.fromJson(e))
            .toList());
  }
}
