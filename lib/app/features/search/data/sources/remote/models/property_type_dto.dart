import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/search/domain/models/property_type.dart';

part 'property_type_dto.g.dart';

/// API model for PropertyType - handles JSON serialization from API
@JsonSerializable()
class PropertyTypeDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'icon')
  final PropertyTypeIconDto? icon;

  @JsonKey(name: 'has_land_area')
  final bool? hasLandArea;

  @JsonKey(name: 'has_mandatory_garden_area')
  final bool? hasMandatoryGardenArea;

  @JsonKey(name: 'manual_ranking')
  final int? manualRanking;

  const PropertyTypeDto({
    required this.id,
    required this.name,
    this.icon,
    this.hasLandArea,
    this.hasMandatoryGardenArea,
    this.manualRanking,
  });

  factory PropertyTypeDto.fromJson(Map<String, dynamic> json) => _$PropertyTypeDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyTypeDtoToJson(this);

  /// Convert API model to domain entity
  PropertyType toEntity() {
    return PropertyType(
      id: id,
      name: name,
      iconUrl: icon?.url,
      hasLandArea: hasLandArea ?? false,
      hasMandatoryGardenArea: hasMandatoryGardenArea ?? false,
      manualRanking: manualRanking,
    );
  }

  /// Create API model from domain entity
  factory PropertyTypeDto.fromEntity(PropertyType entity) {
    return PropertyTypeDto(
      id: entity.id,
      name: entity.name,
      icon: entity.iconUrl != null ? PropertyTypeIconDto(url: entity.iconUrl!) : null,
      hasLandArea: entity.hasLandArea,
      hasMandatoryGardenArea: entity.hasMandatoryGardenArea,
      manualRanking: entity.manualRanking,
    );
  }
}

@JsonSerializable()
class PropertyTypeIconDto {
  @JsonKey(name: 'url')
  final String url;

  const PropertyTypeIconDto({required this.url});

  factory PropertyTypeIconDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyTypeIconDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyTypeIconDtoToJson(this);
}
