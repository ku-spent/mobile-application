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

import 'package:hive/hive.dart';

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

part 'News.g.dart';

/** This is an auto generated class representing the News type in your schema. */
@immutable
@HiveType(typeId: 1)
class News extends Model {
  static const classType = const NewsType();
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String summary;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String source;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final DateTime pubDate;
  @HiveField(8)
  final List<History> histories;
  @HiveField(9)
  final List<Bookmark> bookmarks;
  @HiveField(10)
  final List<UserNewsAction> userActions;
  @HiveField(11)
  final DateTime createdAt;
  @HiveField(12)
  final DateTime updatedAt;

  static String boxName = 'NEWS';

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const News._internal(
      {@required this.id,
      @required this.url,
      @required this.title,
      @required this.summary,
      @required this.image,
      @required this.source,
      @required this.category,
      @required this.pubDate,
      this.histories,
      this.bookmarks,
      this.userActions,
      @required this.createdAt,
      @required this.updatedAt});

  factory News(
      {@required String id,
      @required String url,
      @required String title,
      @required String summary,
      @required String image,
      @required String source,
      @required String category,
      @required DateTime pubDate,
      List<History> histories,
      List<Bookmark> bookmarks,
      List<UserNewsAction> userActions,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return News._internal(
        id: id == null ? UUID.getUUID() : id,
        url: url,
        title: title,
        summary: summary,
        image: image,
        source: source,
        category: category,
        pubDate: pubDate,
        histories: histories != null ? List.unmodifiable(histories) : histories,
        bookmarks: bookmarks != null ? List.unmodifiable(bookmarks) : bookmarks,
        userActions: userActions != null ? List.unmodifiable(userActions) : userActions,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is News &&
        id == other.id &&
        url == other.url &&
        title == other.title &&
        summary == other.summary &&
        image == other.image &&
        source == other.source &&
        category == other.category &&
        pubDate == other.pubDate &&
        DeepCollectionEquality().equals(histories, other.histories) &&
        DeepCollectionEquality().equals(bookmarks, other.bookmarks) &&
        DeepCollectionEquality().equals(userActions, other.userActions) &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("News {");
    buffer.write("id=" + id + ", ");
    buffer.write("url=" + url + ", ");
    buffer.write("title=" + title + ", ");
    buffer.write("summary=" + summary + ", ");
    buffer.write("image=" + image + ", ");
    buffer.write("source=" + source + ", ");
    buffer.write("category=" + category + ", ");
    buffer.write("pubDate=" + (pubDate != null ? pubDate.toDateTimeIso8601String() : "null") + ", ");
    buffer.write("createdAt=" + (createdAt != null ? createdAt.toDateTimeIso8601String() : "null") + ", ");
    buffer.write("updatedAt=" + (updatedAt != null ? updatedAt.toDateTimeIso8601String() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  News copyWith(
      {@required String id,
      @required String url,
      @required String title,
      @required String summary,
      @required String image,
      @required String source,
      @required String category,
      @required DateTime pubDate,
      List<History> histories,
      List<Bookmark> bookmarks,
      List<UserNewsAction> userActions,
      @required DateTime createdAt,
      @required DateTime updatedAt}) {
    return News(
        id: id ?? this.id,
        url: url ?? this.url,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        image: image ?? this.image,
        source: source ?? this.source,
        category: category ?? this.category,
        pubDate: pubDate ?? this.pubDate,
        histories: histories ?? this.histories,
        bookmarks: bookmarks ?? this.bookmarks,
        userActions: userActions ?? this.userActions,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  News.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        url = json['url'],
        title = json['title'],
        summary = json['summary'],
        image = json['image'],
        source = json['source'],
        category = json['category'],
        pubDate = DateTimeParse.fromString(json['pubDate']),
        histories = json['histories'] is List
            ? (json['histories'] as List).map((e) => History.fromJson(new Map<String, dynamic>.from(e))).toList()
            : null,
        bookmarks = json['bookmarks'] is List
            ? (json['bookmarks'] as List).map((e) => Bookmark.fromJson(new Map<String, dynamic>.from(e))).toList()
            : null,
        userActions = json['userActions'] is List
            ? (json['userActions'] as List)
                .map((e) => UserNewsAction.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        createdAt = DateTimeParse.fromString(json['createdAt']),
        updatedAt = DateTimeParse.fromString(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'title': title,
        'summary': summary,
        'image': image,
        'source': source,
        'category': category,
        'pubDate': pubDate?.toDateTimeIso8601String(),
        'histories': histories?.map((e) => e?.toJson()),
        'bookmarks': bookmarks?.map((e) => e?.toJson()),
        'userActions': userActions?.map((e) => e?.toJson()),
        'createdAt': createdAt?.toDateTimeIso8601String(),
        'updatedAt': updatedAt?.toDateTimeIso8601String()
      };

  static final QueryField ID = QueryField(fieldName: "news.id");
  static final QueryField URL = QueryField(fieldName: "url");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField SUMMARY = QueryField(fieldName: "summary");
  static final QueryField IMAGE = QueryField(fieldName: "image");
  static final QueryField SOURCE = QueryField(fieldName: "source");
  static final QueryField CATEGORY = QueryField(fieldName: "category");
  static final QueryField PUBDATE = QueryField(fieldName: "pubDate");
  static final QueryField HISTORIES = QueryField(
      fieldName: "histories", fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (History).toString()));
  static final QueryField BOOKMARKS = QueryField(
      fieldName: "bookmarks", fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Bookmark).toString()));
  static final QueryField USERACTIONS = QueryField(
      fieldName: "userActions",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserNewsAction).toString()));
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField UPDATEDAT = QueryField(fieldName: "updatedAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "News";
    modelSchemaDefinition.pluralName = "News";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(
        ModelFieldDefinition.field(key: News.URL, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.TITLE, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.SUMMARY, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.IMAGE, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.SOURCE, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.CATEGORY, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.PUBDATE, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: News.HISTORIES, isRequired: false, ofModelName: (History).toString(), associatedKey: History.NEWS));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: News.BOOKMARKS, isRequired: false, ofModelName: (Bookmark).toString(), associatedKey: Bookmark.NEWS));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: News.USERACTIONS,
        isRequired: false,
        ofModelName: (UserNewsAction).toString(),
        associatedKey: UserNewsAction.NEWS));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.CREATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: News.UPDATEDAT, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class NewsType extends ModelType<News> {
  const NewsType();

  @override
  News fromJson(Map<String, dynamic> jsonData) {
    return News.fromJson(jsonData);
  }
}
