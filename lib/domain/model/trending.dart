import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/trending_topic.dart';

class Trending extends Equatable {
  final List<String> topics;
  final List<TrendingTopic> trendingTopics;

  const Trending({@required this.topics, @required this.trendingTopics});

  factory Trending.fromJson(Map<String, dynamic> trending) {
    final List<TrendingTopic> trendingTopics =
        trending['feeds'].map<TrendingTopic>((feeds) => TrendingTopic.fromJson(feeds)).toList();
    final List<String> topics = List<String>.from(trending['trends']);
    return Trending(topics: topics, trendingTopics: trendingTopics);
  }

  @override
  List<Object> get props => [topics, trendingTopics];
}
