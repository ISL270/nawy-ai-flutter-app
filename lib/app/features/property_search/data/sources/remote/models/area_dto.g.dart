// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaDto _$AreaDtoFromJson(Map<String, dynamic> json) => AreaDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String?,
  allSlugs: (json['all_slugs'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$AreaDtoToJson(AreaDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'all_slugs': instance.allSlugs,
};
