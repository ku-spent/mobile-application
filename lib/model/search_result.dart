import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String name;
  final ResultType type;

  @override
  List<Object> get props => [name, type];

  const SearchResult({@required this.name, @required this.type});

  factory SearchResult.fromJson(Map<String, dynamic> result) {
    final ResultType type = ResultTypeEnum[result['type']];
    return SearchResult(name: result['name'], type: type);
  }

  @override
  String toString() => 'Result(name: $name, type: $type)';
}

enum ResultType {
  topic,
  source,
  news,
}

const Map<String, ResultType> ResultTypeEnum = {
  'topic': ResultType.topic,
  'source': ResultType.source,
  'news': ResultType.news
};

const Map<ResultType, String> ResultName = {
  ResultType.topic: 'หัวข้อ',
  ResultType.source: 'แหล่งข่าว',
  ResultType.news: 'ข่าว'
};
