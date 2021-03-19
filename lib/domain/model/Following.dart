import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spent/presentation/helper.dart';

enum FollowingType { SOURCE, TAG }

class Following extends Equatable {
  final String id;
  final String name;
  final FollowingType type;

  const Following({
    @required this.id,
    @required this.name,
    @required this.type,
  });

  @override
  List<Object> get props => [id, name, type];

  Following.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = enumFromString<FollowingType>(json['type'], FollowingType.values);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "type": enumToString(type)};
}
