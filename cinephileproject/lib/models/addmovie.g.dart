// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addmovie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddmovieAdapter extends TypeAdapter<Addmovie> {
  @override
  final int typeId = 0;

  @override
  Addmovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Addmovie(
      movieTitle: fields[0] as String,
      year: fields[1] as int,
      language: fields[2] as String,
      runtime: fields[3] as int,
      director: fields[4] as String,
      rating: fields[5] as String,
      genre: fields[6] as String,
      review: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Addmovie obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.movieTitle)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.runtime)
      ..writeByte(4)
      ..write(obj.director)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.genre)
      ..writeByte(7)
      ..write(obj.review);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddmovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
