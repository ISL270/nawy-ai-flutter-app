import 'package:json_annotation/json_annotation.dart';
import 'developer.dart';

part 'developer_dto.g.dart';

/// API model for Developer - handles JSON serialization from API
@JsonSerializable()
class DeveloperDto {
  @JsonKey(name: 'id')
  final int id;
  
  @JsonKey(name: 'name')
  final String name;
  
  @JsonKey(name: 'slug')
  final String? slug;
  
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  const DeveloperDto({
    required this.id,
    required this.name,
    this.slug,
    this.logoPath,
  });

  factory DeveloperDto.fromJson(Map<String, dynamic> json) => _$DeveloperDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DeveloperDtoToJson(this);

  /// Convert API model to domain entity
  Developer toEntity() {
    return Developer(
      id: id,
      name: name,
      slug: slug,
      logoPath: logoPath,
    );
  }

  /// Create API model from domain entity
  factory DeveloperDto.fromEntity(Developer entity) {
    return DeveloperDto(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      logoPath: entity.logoPath,
    );
  }
}
