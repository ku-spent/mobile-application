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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the History type in your schema. */
@immutable
class History extends Model {
  static const classType = const HistoryType();
  final String id;
  final User user;
  final String newId;
  final HistoryStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const History._internal(
      {@required this.id,
      @required this.user,
      @required this.newId,
      @required this.status,
      @required this.createdAt,
      @required this.updatedAt});

  factory History(
      {@required String id,
      @required User user,
      @required String newId,
      @required HistoryStatus status,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return History._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        newId: newId,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is History &&
        id == other.id &&
        user == other.user &&
        newId == other.newId &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("History {");
    buffer.write("id=" + id + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("newId=" + newId + ", ");
    buffer.write("status=" + enumToString(status) + ", ");
    buffer.write("createdAt=" + (createdAt != null ? createdAt.toDateTimeIso8601String() : "null") + ", ");
    buffer.write("updatedAt=" + (updatedAt != null ? updatedAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  History copyWith(
      {@required String id,
      @required User user,
      @required String newId,
      @required HistoryStatus status,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return History(
        id: id ?? this.id,
        user: user ?? this.user,
        newId: newId ?? this.newId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(new Map<String, dynamic>.from(json['user'])) : null,
        newId = json['newId'],
        status = enumFromString<HistoryStatus>(json['status'], HistoryStatus.values),
        createdAt = DateTimeParse.fromString(json['createdAt']),
        updatedAt = DateTimeParse.fromString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'newId': newId,
        'status': enumToString(status),
        'createdAt': createdAt?.toDateTimeIso8601String(),
        'updatedAt': updatedAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "history.id");
  static final QueryField USER = QueryField(
      fieldName: "user", fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField NEWID = QueryField(fieldName: "newId");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "History";
    modelSchemaDefinition.pluralName = "Histories";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: History.USER, isRequired: true, targetName: "userId", ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.NEWID, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.STATUS, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.CREATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.UPDATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class HistoryType extends ModelType<History> {
  const HistoryType();

  @override
  History fromJson(Map<String, dynamic> jsonData) {
    return History.fromJson(jsonData);
  }
}
