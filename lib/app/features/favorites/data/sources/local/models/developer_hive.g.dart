// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeveloperHiveAdapter extends TypeAdapter<DeveloperHive> {
  @override
  final typeId = 3;

  @override
  DeveloperHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeveloperHive()
      ..developerId = (fields[0] as num).toInt()
      ..name = fields[1] as String
      ..slug = fields[2] as String?
      ..logoPath = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, DeveloperHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.developerId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.logoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeveloperHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
