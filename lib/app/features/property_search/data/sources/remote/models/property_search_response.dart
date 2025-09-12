import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_dto.dart';

part 'property_search_response.g.dart';

@JsonSerializable()
class PropertySearchResponse {
  @JsonKey(name: 'total_compounds')
  final int totalCompounds;

  @JsonKey(name: 'total_properties')
  final int totalProperties;

  @JsonKey(name: 'total_property_groups')
  final int totalPropertyGroups;

  @JsonKey(name: 'property_types')
  final List<PropertyTypeCount>? propertyTypes;

  @JsonKey(name: 'values')
  final List<PropertyDto> properties;

  PropertySearchResponse({
    required this.totalCompounds,
    required this.totalProperties,
    required this.totalPropertyGroups,
    required this.properties,
    this.propertyTypes,
  });

  factory PropertySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertySearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PropertySearchResponseToJson(this);
}

@JsonSerializable()
class PropertyTypeCount {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'count')
  final int count;

  PropertyTypeCount({required this.id, required this.count});

  factory PropertyTypeCount.fromJson(Map<String, dynamic> json) =>
      _$PropertyTypeCountFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyTypeCountToJson(this);
}
