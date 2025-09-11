// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compound_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompoundHiveAdapter extends TypeAdapter<CompoundHive> {
  @override
  final typeId = 1;

  @override
  CompoundHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompoundHive()
      ..compoundId = (fields[0] as num).toInt()
      ..areaId = (fields[1] as num).toInt()
      ..name = fields[2] as String
      ..slug = fields[3] as String?
      ..imagePath = fields[4] as String?
      ..developerId = (fields[5] as num?)?.toInt()
      ..updatedAt = fields[6] as DateTime?
      ..nawyOrganizationId = (fields[7] as num?)?.toInt()
      ..hasOffers = fields[8] as bool
      ..isFavorite = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, CompoundHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.compoundId)
      ..writeByte(1)
      ..write(obj.areaId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.slug)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.developerId)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.nawyOrganizationId)
      ..writeByte(8)
      ..write(obj.hasOffers)
      ..writeByte(9)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompoundHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
