// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterOptions _$FilterOptionsFromJson(Map<String, dynamic> json) =>
    FilterOptions(
      minBedrooms: (json['min_bedrooms'] as num).toInt(),
      maxBedrooms: (json['max_bedrooms'] as num).toInt(),
      minPriceList: (json['min_price_list'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      maxPriceList: (json['max_price_list'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      propertyTypes: (json['property_types'] as List<dynamic>?)
          ?.map((e) => PropertyTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortings: (json['sortings'] as List<dynamic>?)
          ?.map((e) => SortOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      saleTypes: (json['sale_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FilterOptionsToJson(FilterOptions instance) =>
    <String, dynamic>{
      'min_bedrooms': instance.minBedrooms,
      'max_bedrooms': instance.maxBedrooms,
      'min_price_list': instance.minPriceList,
      'max_price_list': instance.maxPriceList,
      'property_types': instance.propertyTypes,
      'amenities': instance.amenities,
      'sortings': instance.sortings,
      'sale_types': instance.saleTypes,
    };

Amenity _$AmenityFromJson(Map<String, dynamic> json) => Amenity(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  imagePath: json['image_path'] as String?,
);

Map<String, dynamic> _$AmenityToJson(Amenity instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image_path': instance.imagePath,
};

SortOption _$SortOptionFromJson(Map<String, dynamic> json) => SortOption(
  key: json['key'] as String,
  value: json['value'] as String,
  direction: json['direction'] as String,
);

Map<String, dynamic> _$SortOptionToJson(SortOption instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'direction': instance.direction,
    };
