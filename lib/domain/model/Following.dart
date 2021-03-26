import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spent/presentation/helper.dart';

enum FollowingType { SOURCE, TAG, CATEGORY }

@HiveType(typeId: 2)
class Following extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
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
