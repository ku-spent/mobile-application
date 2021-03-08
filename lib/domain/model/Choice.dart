import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/domain/model/BlockTypes.dart';

class BlockChoice extends Choice with EquatableMixin {
  final String name;
  final BlockTypes type;

  BlockChoice({@required this.name, @required this.type});

  @override
  String get title => name;

  @override
  List<Object> get props => [name, type];
}

abstract class Choice {
  String title;
  String value;
}
