// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'News.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 1;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      id: fields[0] as String,
      url: fields[1] as String,
      title: fields[2] as String,
      summary: fields[3] as String,
      image: fields[4] as String,
      source: fields[5] as String,
      category: fields[6] as String,
      pubDate: fields[7] as DateTime,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      tags: (fields[10] as List)?.cast<String>(),
      rawHTMLContent: fields[11] as String,
      esId: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.summary)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.source)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.pubDate)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.rawHTMLContent)
      ..writeByte(12)
      ..write(obj.esId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
