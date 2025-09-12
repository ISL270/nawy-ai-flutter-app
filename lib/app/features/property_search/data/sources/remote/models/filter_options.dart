import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_type_dto.dart';

part 'filter_options.g.dart';

@JsonSerializable()
class FilterOptions {
  @JsonKey(name: 'min_bedrooms')
  final int minBedrooms;

  @JsonKey(name: 'max_bedrooms')
  final int maxBedrooms;

  @JsonKey(name: 'min_price_list')
  final List<int> minPriceList;

  @JsonKey(name: 'max_price_list')
  final List<int> maxPriceList;

  @JsonKey(name: 'property_types')
  final List<PropertyTypeDto>? propertyTypes;

  @JsonKey(name: 'amenities')
  final List<Amenity>? amenities;

  @JsonKey(name: 'sortings')
  final List<SortOption>? sortings;

  @JsonKey(name: 'sale_types')
  final List<String>? saleTypes;

  FilterOptions({
    required this.minBedrooms,
    required this.maxBedrooms,
    required this.minPriceList,
    required this.maxPriceList,
    this.propertyTypes,
    this.amenities,
    this.sortings,
    this.saleTypes,
  });

  factory FilterOptions.fromJson(Map<String, dynamic> json) => _$FilterOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$FilterOptionsToJson(this);
}

@JsonSerializable()
class Amenity {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'image_path')
  final String? imagePath;

  Amenity({required this.id, required this.name, this.imagePath});

  factory Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);
  Map<String, dynamic> toJson() => _$AmenityToJson(this);
}

@JsonSerializable()
class SortOption {
  @JsonKey(name: 'key')
  final String key;

  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'direction')
  final String direction;

  SortOption({required this.key, required this.value, required this.direction});

  factory SortOption.fromJson(Map<String, dynamic> json) => _$SortOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SortOptionToJson(this);
}
