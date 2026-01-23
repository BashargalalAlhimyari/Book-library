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
      bookId: fields[0] as String,
      title: fields[1] as String,
      authors: (fields[2] as List?)?.cast<String>(),
      description: fields[3] as String?,
      categories: (fields[4] as List?)?.cast<String>(),
      images: (fields[5] as List?)?.cast<String>(),
      subtitle: fields[6] as String?,
      coverUrl: fields[7] as String?,
      price: fields[8] as num?,
      averageRating: fields[9] as num?,
      ratingCount: fields[10] as int?,
      fileUrl: fields[11] as String?,
      pageCount: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.categories)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.subtitle)
      ..writeByte(7)
      ..write(obj.coverUrl)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.averageRating)
      ..writeByte(10)
      ..write(obj.ratingCount)
      ..writeByte(11)
      ..write(obj.fileUrl)
      ..writeByte(11)
      ..write(obj.fileUrl);
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
