import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String url;
  final String title;
  final String summary;
  final String image;
  final String source;
  final DateTime pubDate;

  @override
  List<Object> get props => [url];

  const News({
    @required this.url,
    @required this.title,
    @required this.summary,
    @required this.image,
    @required this.source,
    @required this.pubDate,
  });

  factory News.fromJson(Map<String, dynamic> news) {
    return News(
        url: news['url'] ?? '',
        title: news['title'] ?? '',
        summary: news['summary'] ?? '',
        image: news['image'] ?? '',
        source: news['source'] ?? '',
        pubDate: DateTime.parse(news['pubDate']));
  }
}

class NewsSource {
  static const String voiceTV = 'Voice TV';
  static const String matichon = 'มติชน';
  static const String thaipbs = 'thaipbs';

  static const List<String> values = [
    voiceTV,
    matichon,
    thaipbs,
  ];

  static Map<String, String> newsSourceIcon = {
    voiceTV: 'https://voicetv.co.th/images/icons/favicon-32x32.png',
    matichon:
        'https://www.matichon.co.th/wp-content/themes/matichon-theme/images/matichon-logo-retina.png',
    thaipbs: 'https://news.thaipbs.or.th/favicon.ico',
  };

  static Map<String, String> newsSourceCover = {
    voiceTV:
        'https://www.thairath.co.th/media/dFQROr7oWzulq5FZUIEyjkIzuxZVM7y9dNXa6BvDcWSyyVFqz6CEowoMZWpKrcbE7su.jpg',
    matichon:
        'https://www.khaosod.co.th/wpapp/uploads/2020/02/%E0%B8%A1%E0%B8%95%E0%B8%B4%E0%B8%8A%E0%B8%99.jpg',
    thaipbs: 'https://www.thaipbs.or.th/images/logo/home_logo.jpg',
  };
}
