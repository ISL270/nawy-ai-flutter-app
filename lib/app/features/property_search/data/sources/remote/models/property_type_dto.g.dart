// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyTypeDto _$PropertyTypeDtoFromJson(Map<String, dynamic> json) =>
    PropertyTypeDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      icon: json['icon'] == null
          ? null
          : PropertyTypeIconDto.fromJson(json['icon'] as Map<String, dynamic>),
      hasLandArea: json['has_land_area'] as bool?,
      hasMandatoryGardenArea: json['has_mandatory_garden_area'] as bool?,
      manualRanking: (json['manual_ranking'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PropertyTypeDtoToJson(PropertyTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'has_land_area': instance.hasLandArea,
      'has_mandatory_garden_area': instance.hasMandatoryGardenArea,
      'manual_ranking': instance.manualRanking,
    };

PropertyTypeIconDto _$PropertyTypeIconDtoFromJson(Map<String, dynamic> json) =>
    PropertyTypeIconDto(url: json['url'] as String);

Map<String, dynamic> _$PropertyTypeIconDtoToJson(
  PropertyTypeIconDto instance,
) => <String, dynamic>{'url': instance.url};
