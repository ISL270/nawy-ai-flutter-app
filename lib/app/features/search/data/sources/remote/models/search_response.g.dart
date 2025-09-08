// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      totalCompounds: (json['total_compounds'] as num).toInt(),
      totalProperties: (json['total_properties'] as num).toInt(),
      totalPropertyGroups: (json['total_property_groups'] as num).toInt(),
      properties: (json['values'] as List<dynamic>)
          .map((e) => PropertyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      propertyTypes: (json['property_types'] as List<dynamic>?)
          ?.map((e) => PropertyTypeCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'total_compounds': instance.totalCompounds,
      'total_properties': instance.totalProperties,
      'total_property_groups': instance.totalPropertyGroups,
      'property_types': instance.propertyTypes,
      'values': instance.properties,
    };

PropertyTypeCount _$PropertyTypeCountFromJson(Map<String, dynamic> json) =>
    PropertyTypeCount(
      id: (json['id'] as num).toInt(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$PropertyTypeCountToJson(PropertyTypeCount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
    };
