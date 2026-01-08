// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookEntityAdapter extends TypeAdapter<BookEntity> {
  @override
  final int typeId = 0;

  @override
  BookEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookEntity(
      descrption: fields[4] as String?,
      bookId: fields[0] as String,
      images: (fields[6] as List?)?.cast<String>(),
      title: fields[2] as String,
      authOrName: fields[3] as String?,
      categories: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.authOrName)
      ..writeByte(4)
      ..write(obj.descrption)
      ..writeByte(5)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
