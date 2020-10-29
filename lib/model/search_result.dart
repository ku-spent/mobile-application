import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String name;

  @override
  List<Object> get props => [
        name,
      ];

  const SearchResult({@required this.name});

  factory SearchResult.fromJson(Map<String, dynamic> result) {
    return SearchResult(name: result['name']);
  }

  @override
  String toString() => 'Result(name: $name)';
}

class ResultType {
  static String topic = 'หัวข้อ';
  static String source = 'แหล่งข่าว';
  static String category = 'ประเภท';
}
