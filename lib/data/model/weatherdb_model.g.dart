// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherdb_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherInfoDBAdapter extends TypeAdapter<WeatherInfoDB> {
  @override
  final int typeId = 0;

  @override
  WeatherInfoDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherInfoDB(
      description: fields[0] as String,
      icon: fields[1] as String,
      mainTitle: fields[2] as String,
      temp: fields[3] as String,
      feelsLike: fields[4] as String,
      pressure: fields[5] as String,
      humidity: fields[6] as String,
      windSpeed: fields[7] as String,
      cityId: fields[8] as int,
      city: fields[9] as String,
      unixTimeStamp: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherInfoDB obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.mainTitle)
      ..writeByte(3)
      ..write(obj.temp)
      ..writeByte(4)
      ..write(obj.feelsLike)
      ..writeByte(5)
      ..write(obj.pressure)
      ..writeByte(6)
      ..write(obj.humidity)
      ..writeByte(7)
      ..write(obj.windSpeed)
      ..writeByte(8)
      ..write(obj.cityId)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.unixTimeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherInfoDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
