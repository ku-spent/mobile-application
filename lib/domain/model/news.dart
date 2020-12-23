import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'news.g.dart';

@HiveType(typeId: 1)
class News extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String summary;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String source;

  @HiveField(6)
  final DateTime pubDate;

  @HiveField(7)
  final String category;

  static const String boxName = 'news';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'summary': summary,
      'image': image,
      'source': source,
      'pubDate': pubDate,
      'category': category,
    };
  }
}
