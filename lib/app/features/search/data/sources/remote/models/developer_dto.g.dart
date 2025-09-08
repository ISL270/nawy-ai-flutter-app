// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeveloperDto _$DeveloperDtoFromJson(Map<String, dynamic> json) => DeveloperDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String?,
  logoPath: json['logo_path'] as String?,
);

Map<String, dynamic> _$DeveloperDtoToJson(DeveloperDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'logo_path': instance.logoPath,
    };
