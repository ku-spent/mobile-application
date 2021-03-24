import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:spent/domain/model/category.dart';
import 'package:spent/domain/model/news_source.dart';
import 'package:spent/presentation/AppRouter.gr.dart';
import 'package:spent/presentation/bloc/query/query_bloc.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String enumToString(Object o) => o != null ? o.toString().split('.').last : null;

T enumFromString<T>(String key, List<T> values) => values.firstWhere((v) => key == enumToString(v), orElse: () => null);

void goToQuerySourcePage(BuildContext context, String source) {
  ExtendedNavigator.of(context).push(
    Routes.queryPage,
    arguments: QueryPageArguments(
      query: QueryWithField(source, query: source, queryField: QueryField.source),
      coverUrl: NewsSource.newsSourceCover[source],
      isShowTitle: true,
    ),
  );
}

void goToQueryTagPage(BuildContext context, String tag) {
  ExtendedNavigator.of(context).push(
    Routes.queryPage,
    arguments: QueryPageArguments(
        query: QueryWithField(tag, query: tag, queryField: QueryField.tags),
        isShowTitle: true,
        coverUrl: Category.newsCategoryCover[Category.localNews]),
  );
}

void goToQueryCategoryPage(BuildContext context, String category) {
  ExtendedNavigator.of(context).push(
    Routes.queryPage,
    arguments: QueryPageArguments(
      query: QueryWithField(category, query: category, queryField: QueryField.category),
      isShowTitle: true,
      coverUrl: Category.newsCategoryCover[category],
    ),
  );
}
