/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

import 'package:spent/domain/model/BlockTypes.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Block type in your schema. */
@immutable
class Block extends Model {
  static const classType = const BlockType();
  final String id;
  final String userId;
  final String name;
  final BlockTypes type;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Block._internal(
      {@required this.id,
      @required this.userId,
      @required this.name,
      @required this.type,
      @required this.createdAt,
      @required this.updatedAt});

  factory Block(
      {@required String id,
      @required String userId,
      @required String name,
      @required BlockTypes type,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return Block._internal(
        id: id == null ? UUID.getUUID() : id,
        userId: userId,
        name: name,
        type: type,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Block &&
        id == other.id &&
        userId == other.userId &&
        name == other.name &&
        type == other.type &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Block {");
    buffer.write("id=" + id + ", ");
    buffer.write("userId=" + userId + ", ");
    buffer.write("name=" + name + ", ");
    buffer.write("type=" + enumToString(type) + ", ");
    buffer.write("createdAt=" + (createdAt != null ? createdAt.toDateTimeIso8601String() : "null") + ", ");
    buffer.write("updatedAt=" + (updatedAt != null ? updatedAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Block copyWith(
      {@required String id,
      @required String userId,
      @required String name,
      @required BlockTypes type,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return Block(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Block.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        name = json['name'],
        type = enumFromString<BlockTypes>(json['type'], BlockTypes.values),
        createdAt = DateTimeParse.fromString(json['createdAt']),
        updatedAt = DateTimeParse.fromString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'type': enumToString(type),
        'createdAt': createdAt?.toDateTimeIso8601String(),
        'updatedAt': updatedAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "block.id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Block";
    modelSchemaDefinition.pluralName = "Blocks";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Block.USERID, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Block.NAME, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Block.TYPE, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Block.CREATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Block.UPDATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class BlockType extends ModelType<Block> {
  const BlockType();

  @override
  Block fromJson(Map<String, dynamic> jsonData) {
    return Block.fromJson(jsonData);
  }
}
