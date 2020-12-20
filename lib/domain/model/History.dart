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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the History type in your schema. */
@immutable
class History extends Model {
  static const classType = const HistoryType();
  final String id;
  final String newId;
  final String userId;
  final DateTime createdAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const History._internal(
      {@required this.id,
      @required this.newId,
      @required this.userId,
      this.createdAt});

  factory History(
      {@required String id,
      @required String newId,
      @required String userId,
      DateTime createdAt}) {
    return History._internal(
        id: id == null ? UUID.getUUID() : id,
        newId: newId,
        userId: userId,
        createdAt: createdAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is History &&
        id == other.id &&
        newId == other.newId &&
        userId == other.userId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("History {");
    buffer.write("id=" + id + ", ");
    buffer.write("newId=" + newId + ", ");
    buffer.write("userId=" + userId + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  History copyWith(
      {@required String id,
      @required String newId,
      @required String userId,
      DateTime createdAt}) {
    return History(
        id: id ?? this.id,
        newId: newId ?? this.newId,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt);
  }

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        newId = json['newId'],
        userId = json['userId'],
        createdAt = DateTimeParse.fromString(json['createdAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'newId': newId,
        'userId': userId,
        'createdAt': createdAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "history.id");
  static final QueryField NEWID = QueryField(fieldName: "newId");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "History";
    modelSchemaDefinition.pluralName = "Histories";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          operations: [
            ModelOperation.CREATE,
            ModelOperation.UPDATE,
            ModelOperation.DELETE,
            ModelOperation.READ
          ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.NEWID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class HistoryType extends ModelType<History> {
  const HistoryType();

  @override
  History fromJson(Map<String, dynamic> jsonData) {
    return History.fromJson(jsonData);
  }
}
