import 'package:hive_ce/hive.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart' as domain;

part 'area_hive.g.dart';

/// Persistence model for Area - handles local storage
@HiveType(typeId: 2)
class AreaHive extends HiveObject {
  @HiveField(0)
  late int areaId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? slug;

  @HiveField(3)
  Map<String, String>? translations;

  AreaHive();

  AreaHive._({
    required this.areaId,
    required this.name,
    this.slug,
    this.translations,
  });

  /// Convert persistence model to domain entity
  domain.Area toEntity() {
    return domain.Area(
      id: areaId,
      name: name,
      slug: slug,
      translations: translations,
    );
  }

  /// Create persistence model from domain entity
  factory AreaHive.fromEntity(domain.Area entity) {
    return AreaHive._(
      areaId: entity.id,
      name: entity.name,
      slug: entity.slug,
      translations: entity.translations,
    );
  }
}
