import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart';

part 'area_dto.g.dart';

/// API model for Area - handles JSON serialization
@JsonSerializable()
class AreaDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'all_slugs')
  final Map<String, String>? allSlugs;

  const AreaDto({required this.id, required this.name, this.slug, this.allSlugs});

  factory AreaDto.fromJson(Map<String, dynamic> json) => _$AreaDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AreaDtoToJson(this);

  /// Convert API model to domain entity
  Area toEntity() {
    return Area(id: id, name: name, slug: slug, translations: allSlugs);
  }

  /// Create API model from domain entity
  factory AreaDto.fromEntity(Area entity) {
    return AreaDto(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      allSlugs: entity.translations,
    );
  }
}
