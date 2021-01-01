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
import 'package:hive/hive.dart';
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
  final DateTime createdAt;
  @HiveField(9)
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
