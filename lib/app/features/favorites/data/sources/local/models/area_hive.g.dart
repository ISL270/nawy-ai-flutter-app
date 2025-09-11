// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AreaHiveAdapter extends TypeAdapter<AreaHive> {
  @override
  final typeId = 2;

  @override
  AreaHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AreaHive()
      ..areaId = (fields[0] as num).toInt()
      ..name = fields[1] as String
      ..slug = fields[2] as String?
      ..translations = (fields[3] as Map?)?.cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, AreaHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.areaId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.translations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AreaHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
