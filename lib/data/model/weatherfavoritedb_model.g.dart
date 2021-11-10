// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherfavoritedb_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherFavoriteDBAdapter extends TypeAdapter<WeatherFavoriteDB> {
  @override
  final int typeId = 1;

  @override
  WeatherFavoriteDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherFavoriteDB(
      cityId: fields[0] as int,
      city: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherFavoriteDB obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cityId)
      ..writeByte(1)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherFavoriteDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
