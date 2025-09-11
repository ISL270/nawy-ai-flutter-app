import 'package:hive_ce/hive.dart';
import 'package:nawy_app/app/features/search/domain/models/property_type.dart' as domain;

part 'property_type_hive.g.dart';

/// Persistence model for PropertyType - handles local storage
@HiveType(typeId: 4)
class PropertyTypeHive extends HiveObject {
  @HiveField(0)
  late int propertyTypeId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? iconUrl;

  @HiveField(3)
  bool hasLandArea = false;

  @HiveField(4)
  bool hasMandatoryGardenArea = false;

  @HiveField(5)
  int? manualRanking;

  PropertyTypeHive();

  PropertyTypeHive._({
    required this.propertyTypeId,
    required this.name,
    this.iconUrl,
    this.hasLandArea = false,
    this.hasMandatoryGardenArea = false,
    this.manualRanking,
  });

  /// Convert persistence model to domain entity
  domain.PropertyType toEntity() {
    return domain.PropertyType(
      id: propertyTypeId,
      name: name,
      iconUrl: iconUrl,
      hasLandArea: hasLandArea,
      hasMandatoryGardenArea: hasMandatoryGardenArea,
      manualRanking: manualRanking,
    );
  }

  /// Create persistence model from domain entity
  factory PropertyTypeHive.fromEntity(domain.PropertyType entity) {
    return PropertyTypeHive._(
      propertyTypeId: entity.id,
      name: entity.name,
      iconUrl: entity.iconUrl,
      hasLandArea: entity.hasLandArea,
      hasMandatoryGardenArea: entity.hasMandatoryGardenArea,
      manualRanking: entity.manualRanking,
    );
  }
}
