import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchItem extends Equatable {
  static String topic = 'หัวข้อ';
  static String source = 'แหล่งข่าว';
  static String category = 'ประเภท';
  static String news = 'ข่าว';

  static String topicDescription = 'หัวข้อข่าว';
  static String sourceDescription = 'แหล่งข่าว';
  static String categoryDescription = 'ประเภทข่าว';
  static String newsDescription = 'ข่าว';

  final String value;
  final String type;
  final String description;

  const SearchItem({@required this.value, @required this.type, @required this.description});

  @override
  List<Object> get props => [value, type, description];
}
