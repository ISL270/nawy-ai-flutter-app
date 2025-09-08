import 'package:isar/isar.dart';
import 'package:nawy_app/app/features/search/domain/entities/compound.dart';

part 'compound_isar.g.dart';

/// Persistence model for Compound - handles local storage of favorited compounds only
@Collection()
class CompoundIsar {
  Id isarId = Isar.autoIncrement;

  late int id;
  late int areaId;
  late String name;
  String? slug;
  String? imagePath;
  int? developerId;
  DateTime? updatedAt;
  int? nawyOrganizationId;
  bool hasOffers = false;
  bool isFavorite = false;

  CompoundIsar();

  CompoundIsar._({
    required this.id,
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
      id: id,
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
  factory CompoundIsar.fromEntity(Compound entity) {
    return CompoundIsar._(
      id: entity.id,
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
