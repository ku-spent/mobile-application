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
  final String userId;
  final String newsId;
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
      @required this.userId,
      @required this.newsId,
      @required this.status,
      @required this.createdAt,
      @required this.updatedAt});

  factory History(
      {@required String id,
      @required String userId,
      @required String newsId,
      @required HistoryStatus status,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return History._internal(
        id: id == null ? UUID.getUUID() : id,
        userId: userId,
        newsId: newsId,
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
        userId == other.userId &&
        newsId == other.newsId &&
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
    buffer.write("userId=" + userId + ", ");
    buffer.write("newsId=" + newsId + ", ");
    buffer.write("status=" + enumToString(status) + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toDateTimeIso8601String() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  History copyWith(
      {@required String id,
      @required String userId,
      @required String newsId,
      @required HistoryStatus status,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return History(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        newsId: newsId ?? this.newsId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        newsId = json['newsId'],
        status =
            enumFromString<HistoryStatus>(json['status'], HistoryStatus.values),
        createdAt = DateTimeParse.fromString(json['createdAt']),
        updatedAt = DateTimeParse.fromString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'newsId': newsId,
        'status': enumToString(status),
        'createdAt': createdAt?.toDateTimeIso8601String(),
        'updatedAt': updatedAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "history.id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField NEWSID = QueryField(fieldName: "newsId");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
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
        key: History.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.NEWSID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.STATUS,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.CREATEDAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: History.UPDATEDAT,
        isRequired: true,
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
