import 'package:objectbox/objectbox.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

/// Persistence model for Compound - handles local storage of favorited compounds only
@Entity()
class CompoundObx {
  @Id()
  int id = 0;

  late int compoundId;
  late int areaId;
  late String name;
  String? slug;
  String? imagePath;
  int? developerId;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;
  int? nawyOrganizationId;
  bool hasOffers = false;
  bool isFavorite = false;

  CompoundObx();

  CompoundObx._({
    required this.compoundId,
    required this.areaId,
    required this.name,
    this.slug,
    this.imagePath,
    this.developerId,
    this.updatedAt,
    this.nawyOrganizationId,
    this.hasOffers = false,
    this.isFavorite = false,
  });

  /// Convert persistence model to domain entity
  Compound toEntity() {
    return Compound(
      id: compoundId,
      areaId: areaId,
      name: name,
      slug: slug,
      imagePath: imagePath,
      developerId: developerId,
      updatedAt: updatedAt,
      nawyOrganizationId: nawyOrganizationId,
      hasOffers: hasOffers,
      area: null, // Area relationship handled separately
      isFavorite: isFavorite,
    );
  }

  /// Create persistence model from domain entity
  factory CompoundObx.fromEntity(Compound entity) {
    return CompoundObx._(
      compoundId: entity.id,
      areaId: entity.areaId,
      name: entity.name,
      slug: entity.slug,
      imagePath: entity.imagePath,
      developerId: entity.developerId,
      updatedAt: entity.updatedAt,
      nawyOrganizationId: entity.nawyOrganizationId,
      hasOffers: entity.hasOffers,
      isFavorite: entity.isFavorite,
    );
  }
}
