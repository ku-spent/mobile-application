import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String url;
  final String title;
  final String summary;
  final String imageUrl;
  final String source;
  final DateTime pubDate;

  @override
  List<Object> get props => [url];

  const News({
    @required this.url,
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.source,
    @required this.pubDate,
  });

  factory News.fromJson(Map<String, dynamic> news) {
    return News(
        url: news['url'] ?? '',
        title: news['title'] ?? '',
        summary: news['summary'] ?? '',
        imageUrl: news['imageUrl'] ?? '',
        source: news['source'] ?? '',
        pubDate: DateTime.parse(news['pubDate']));
  }
}
