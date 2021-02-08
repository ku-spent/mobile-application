import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/ModelProvider.dart';

class TrendingTopic extends Equatable {
  final String topic;
  final List<News> newsList;

  const TrendingTopic({@required this.topic, @required this.newsList});

  factory TrendingTopic.fromJson(Map<String, dynamic> trendingTopic) {
    final List<News> newsList =
        trendingTopic['news'].map<News>((e) => News.fromJson(e['_source'], esId: e['_id'])).toList();
    return TrendingTopic(topic: trendingTopic['trend'], newsList: newsList);
  }

  @override
  List<Object> get props => [topic, newsList];
}
