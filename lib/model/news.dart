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

enum EnumNewsSource {
  voiceTV,
  matichon,
  thaipbs,
}

const Map<EnumNewsSource, String> NewsSource = {
  EnumNewsSource.voiceTV: 'Voice TV',
  EnumNewsSource.matichon: 'มติชน',
  EnumNewsSource.thaipbs: 'thaipbs',
};

const Map<EnumNewsSource, String> NewsSourceImage = {
  EnumNewsSource.voiceTV:
      'https://voicetv.co.th/images/icons/favicon-32x32.png',
  EnumNewsSource.matichon:
      'https://www.matichon.co.th/wp-content/themes/matichon-theme/images/matichon-logo-retina.png',
  EnumNewsSource.thaipbs: 'https://news.thaipbs.or.th/favicon.ico',
};
