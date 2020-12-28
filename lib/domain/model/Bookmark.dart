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

/** This is an auto generated class representing the Bookmark type in your schema. */
@immutable
class Bookmark extends Model {
  static const classType = const BookmarkType();
  final String id;
  final User user;
  final News news;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Bookmark._internal(
      {@required this.id,
      @required this.user,
      @required this.news,
      @required this.createdAt,
      @required this.updatedAt});

  factory Bookmark(
      {@required String id,
      @required User user,
      @required News news,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return Bookmark._internal(
        id: id == null ? UUID.getUUID() : id,
        user: user,
        news: news,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bookmark &&
        id == other.id &&
        user == other.user &&
        news == other.news &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Bookmark {");
    buffer.write("id=" + id + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("news=" + (news != null ? news.toString() : "null") + ", ");
    buffer.write("createdAt=" +
        (createdAt != null ? createdAt.toDateTimeIso8601String() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (updatedAt != null ? updatedAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Bookmark copyWith(
      {@required String id,
      @required User user,
      @required News news,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return Bookmark(
        id: id ?? this.id,
        user: user ?? this.user,
        news: news ?? this.news,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Bookmark.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        news = json['news'] != null
            ? News.fromJson(new Map<String, dynamic>.from(json['news']))
            : null,
        createdAt = DateTimeParse.fromString(json['createdAt']),
        updatedAt = DateTimeParse.fromString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'news': news?.toJson(),
        'createdAt': createdAt?.toDateTimeIso8601String(),
        'updatedAt': updatedAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "bookmark.id");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField NEWS = QueryField(
      fieldName: "news",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (News).toString()));
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Bookmark";
    modelSchemaDefinition.pluralName = "Bookmarks";

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

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Bookmark.USER,
        isRequired: true,
        targetName: "userId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Bookmark.NEWS,
        isRequired: true,
        targetName: "newsId",
        ofModelName: (News).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Bookmark.CREATEDAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Bookmark.UPDATEDAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class BookmarkType extends ModelType<Bookmark> {
  const BookmarkType();

  @override
  Bookmark fromJson(Map<String, dynamic> jsonData) {
    return Bookmark.fromJson(jsonData);
  }
}
