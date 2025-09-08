import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

part 'compound_dto.g.dart';

/// API model for Compound - handles JSON serialization from API
@JsonSerializable()
class CompoundDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'area_id')
  final int areaId;

  @JsonKey(name: 'developer_id')
  final int? developerId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'image_path')
  final String? imagePath;

  @JsonKey(name: 'nawy_organization_id')
  final int? nawyOrganizationId;

  @JsonKey(name: 'has_offers')
  final bool? hasOffers;

  @JsonKey(name: 'area')
  final AreaDto? area;

  const CompoundDto({
    required this.id,
    required this.areaId,
    required this.name,
    this.developerId,
    this.slug,
    this.updatedAt,
    this.imagePath,
    this.nawyOrganizationId,
    this.hasOffers,
    this.area,
  });

  factory CompoundDto.fromJson(Map<String, dynamic> json) => _$CompoundDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CompoundDtoToJson(this);

  /// Convert API model to domain entity
  Compound toEntity() {
    DateTime? parsedUpdatedAt;
    if (updatedAt != null) {
      try {
        parsedUpdatedAt = DateTime.parse(updatedAt!);
      } catch (e) {
        // Handle parsing error gracefully
        parsedUpdatedAt = null;
      }
    }

    return Compound(
      id: id,
      areaId: areaId,
      name: name,
      slug: slug,
      imagePath: imagePath,
      developerId: developerId,
      updatedAt: parsedUpdatedAt,
      nawyOrganizationId: nawyOrganizationId,
      hasOffers: hasOffers ?? false,
      area: area?.toEntity(),
      isFavorite: false, // Default value, will be set from persistence layer
    );
  }

  /// Create API model from domain entity
  factory CompoundDto.fromEntity(Compound entity) {
    return CompoundDto(
      id: entity.id,
      areaId: entity.areaId,
      name: entity.name,
      slug: entity.slug,
      imagePath: entity.imagePath,
      developerId: entity.developerId,
      updatedAt: entity.updatedAt?.toIso8601String(),
      nawyOrganizationId: entity.nawyOrganizationId,
      hasOffers: entity.hasOffers,
      area: entity.area != null ? AreaDto.fromEntity(entity.area!) : null,
    );
  }
}
