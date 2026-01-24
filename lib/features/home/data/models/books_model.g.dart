// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksModelAdapter extends TypeAdapter<BooksModel> {
  @override
  final int typeId = 4;

  @override
  BooksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksModel(
      bookId: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      authors: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      coverUrl: fields[5] as String,
      images: (fields[6] as List).cast<String>(),
      categories: (fields[7] as List).cast<String>(),
      price: fields[8] as num,
      averageRating: fields[9] as num,
      ratingCount: fields[10] as int,
      fileUrl: fields[11] as String,
      pageCount: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BooksModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.coverUrl)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.categories)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.averageRating)
      ..writeByte(10)
      ..write(obj.ratingCount)
      ..writeByte(11)
      ..write(obj.fileUrl)
      ..writeByte(12)
      ..write(obj.pageCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
