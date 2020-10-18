import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String name;
  final String type;

  @override
  List<Object> get props => [name, type];

  const SearchResult({@required this.name, @required this.type});

  factory SearchResult.fromJson(Map<String, dynamic> result) {
    return SearchResult(name: result['name'], type: result['type']);
  }

  @override
  String toString() => 'Result(name: $name, type: $type)';
}
