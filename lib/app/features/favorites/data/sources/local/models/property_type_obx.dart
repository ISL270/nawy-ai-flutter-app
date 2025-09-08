import 'package:objectbox/objectbox.dart';
import 'package:nawy_app/app/features/search/domain/models/property_type.dart' as domain;

/// Persistence model for PropertyType - reference data for favorited items (not stored independently)
@Entity()
class PropertyTypeObx {
  @Id()
  int id = 0;

  late int propertyTypeId;
  late String name;
  String? iconUrl;
  bool hasLandArea = false;
  bool hasMandatoryGardenArea = false;
  int? manualRanking;

  PropertyTypeObx();

  PropertyTypeObx._({
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
  factory PropertyTypeObx.fromEntity(domain.PropertyType entity) {
    return PropertyTypeObx._(
      propertyTypeId: entity.id,
      name: entity.name,
      iconUrl: entity.iconUrl,
      hasLandArea: entity.hasLandArea,
      hasMandatoryGardenArea: entity.hasMandatoryGardenArea,
      manualRanking: entity.manualRanking,
    );
  }
}
