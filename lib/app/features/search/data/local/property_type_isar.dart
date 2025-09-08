import 'package:isar/isar.dart';
import 'package:nawy_app/app/features/search/domain/entities/property_type.dart';

part 'property_type_isar.g.dart';

/// Persistence model for PropertyType - reference data for favorited items (not stored independently)
@Collection()
class PropertyTypeIsar {
  Id isarId = Isar.autoIncrement;

  late int id;
  late String name;
  String? iconUrl;
  bool hasLandArea = false;
  bool hasMandatoryGardenArea = false;
  int? manualRanking;

  PropertyTypeIsar();

  PropertyTypeIsar._({
    required this.id,
    required this.name,
    this.iconUrl,
    this.hasLandArea = false,
    this.hasMandatoryGardenArea = false,
    this.manualRanking,
  });

  /// Convert persistence model to domain entity
  PropertyType toEntity() {
    return PropertyType(
      id: id,
      name: name,
      iconUrl: iconUrl,
      hasLandArea: hasLandArea,
      hasMandatoryGardenArea: hasMandatoryGardenArea,
      manualRanking: manualRanking,
    );
  }

  /// Create persistence model from domain entity
  factory PropertyTypeIsar.fromEntity(PropertyType entity) {
    return PropertyTypeIsar._(
      id: entity.id,
      name: entity.name,
      iconUrl: entity.iconUrl,
      hasLandArea: entity.hasLandArea,
      hasMandatoryGardenArea: entity.hasMandatoryGardenArea,
      manualRanking: entity.manualRanking,
    );
  }
}
