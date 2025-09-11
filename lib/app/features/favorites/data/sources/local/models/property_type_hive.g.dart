// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_type_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyTypeHiveAdapter extends TypeAdapter<PropertyTypeHive> {
  @override
  final typeId = 4;

  @override
  PropertyTypeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertyTypeHive()
      ..propertyTypeId = (fields[0] as num).toInt()
      ..name = fields[1] as String
      ..iconUrl = fields[2] as String?
      ..hasLandArea = fields[3] as bool
      ..hasMandatoryGardenArea = fields[4] as bool
      ..manualRanking = (fields[5] as num?)?.toInt();
  }

  @override
  void write(BinaryWriter writer, PropertyTypeHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.propertyTypeId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconUrl)
      ..writeByte(3)
      ..write(obj.hasLandArea)
      ..writeByte(4)
      ..write(obj.hasMandatoryGardenArea)
      ..writeByte(5)
      ..write(obj.manualRanking);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyTypeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
