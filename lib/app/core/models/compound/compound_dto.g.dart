// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compound_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompoundDto _$CompoundDtoFromJson(Map<String, dynamic> json) => CompoundDto(
      id: (json['id'] as num).toInt(),
      areaId: (json['area_id'] as num).toInt(),
      name: json['name'] as String,
      developerId: (json['developer_id'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      updatedAt: json['updated_at'] as String?,
      imagePath: json['image_path'] as String?,
      nawyOrganizationId: (json['nawy_organization_id'] as num?)?.toInt(),
      hasOffers: json['has_offers'] as bool?,
      area: json['area'] == null
          ? null
          : AreaDto.fromJson(json['area'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompoundDtoToJson(CompoundDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'area_id': instance.areaId,
      'developer_id': instance.developerId,
      'name': instance.name,
      'slug': instance.slug,
      'updated_at': instance.updatedAt,
      'image_path': instance.imagePath,
      'nawy_organization_id': instance.nawyOrganizationId,
      'has_offers': instance.hasOffers,
      'area': instance.area,
    };
