import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spent/model/news.dart';
import 'package:http/http.dart' as http;

class FeedRepository {
  final http.Client client;
  final String endpoint = '8exva7q54m.execute-api.ap-southeast-1.amazonaws.com';

  const FeedRepository({@required this.client});

  Future<List<News>> fetchFeeds({
    int from = 0,
    int size = 5,
    String queryField = '_',
    String query,
  }) async {
    try {
      String url = Uri(
        scheme: 'https',
        host: endpoint,
        path: 'dev/feed',
        queryParameters: {
          'from': from.toString(),
          'size': size.toString(),
          queryField: query,
        },
      ).toString();
      final res = await client.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(utf8.decode(res.bodyBytes))['data'];
        List items = data['hits'];
        return items.map((e) => News.fromJson(e['_source'])).toList();
      } else {
        throw Exception('error fetching feeds');
      }
    } catch (e) {
      print(e);
    }
  }
}
