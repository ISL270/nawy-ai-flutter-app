import 'package:hive_ce/hive.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/compound.dart' as domain;

part 'compound_hive.g.dart';

/// Persistence model for Compound - handles local storage of favorited compounds only
@HiveType(typeId: 1)
class CompoundHive extends HiveObject {
  @HiveField(0)
  late int compoundId;

  @HiveField(1)
  late int areaId;

  @HiveField(2)
  late String name;

  @HiveField(3)
  String? slug;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  int? developerId;

  @HiveField(6)
  DateTime? updatedAt;

  @HiveField(7)
  int? nawyOrganizationId;

  @HiveField(8)
  bool hasOffers = false;

  @HiveField(9)
  bool isFavorite = false;

  CompoundHive();

  CompoundHive._({
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
  domain.Compound toEntity() {
    return domain.Compound(
      id: compoundId,
      areaId: areaId,
      name: name,
      slug: slug,
      imagePath: imagePath,
      developerId: developerId,
      updatedAt: updatedAt,
      nawyOrganizationId: nawyOrganizationId,
      hasOffers: hasOffers,
      isFavorite: isFavorite,
    );
  }

  /// Create persistence model from domain entity
  factory CompoundHive.fromEntity(domain.Compound entity) {
    return CompoundHive._(
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
