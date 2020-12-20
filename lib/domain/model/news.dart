import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String id;
  final String url;
  final String title;
  final String summary;
  final String image;
  final String source;
  final DateTime pubDate;
  final String category;

  @override
  List<Object> get props => [
        id,
        url,
        title,
        summary,
        image,
        source,
        pubDate,
        category,
      ];

  const News({
    @required this.id,
    @required this.url,
    @required this.title,
    @required this.summary,
    @required this.image,
    @required this.source,
    @required this.pubDate,
    @required this.category,
  });

  factory News.fromJson(Map<String, dynamic> news) {
    return News(
      id: news['id'] ?? '',
      url: news['url'] ?? '',
      title: news['title'] ?? '',
      summary: news['summary'] ?? '',
      image: news['image'] ?? '',
      source: news['source'] ?? '',
      pubDate: DateTime.parse(news['pubDate']),
      category: news['category'] ?? '',
    );
  }
}
