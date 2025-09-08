import 'package:isar/isar.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';

part 'property_isar.g.dart';

/// Persistence model for Property - handles local storage of favorited properties only
@Collection()
class PropertyIsar {
  Id isarId = Isar.autoIncrement;

  late int id;
  late String name;
  String? slug;
  String? image;
  String? finishing;
  double? minUnitArea;
  double? maxUnitArea;
  double? minPrice;
  double? maxPrice;
  String? currency;
  int? maxInstallmentYears;
  String? maxInstallmentYearsMonths;
  bool isFavorite = false;

  // Related entity IDs (relationships handled separately)
  int? propertyTypeId;
  int? areaId;
  int? developerId;
  int? compoundId;

  PropertyIsar();

  PropertyIsar._({
    required this.id,
    required this.name,
    this.slug,
    this.image,
    this.finishing,
    this.minUnitArea,
    this.maxUnitArea,
    this.minPrice,
    this.maxPrice,
    this.currency,
    this.maxInstallmentYears,
    this.maxInstallmentYearsMonths,
    this.isFavorite = false,
    this.propertyTypeId,
    this.areaId,
    this.developerId,
    this.compoundId,
  });

  /// Convert persistence model to domain entity
  Property toEntity() {
    return Property(
      id: id,
      name: name,
      slug: slug,
      propertyType: null, // Relationships handled separately
      compound: null,
      area: null,
      developer: null,
      image: image,
      finishing: finishing,
      minUnitArea: minUnitArea,
      maxUnitArea: maxUnitArea,
      minPrice: minPrice,
      maxPrice: maxPrice,
      currency: currency,
      maxInstallmentYears: maxInstallmentYears,
      maxInstallmentYearsMonths: maxInstallmentYearsMonths,
      isFavorite: isFavorite,
    );
  }

  /// Create persistence model from domain entity
  factory PropertyIsar.fromEntity(Property entity) {
    return PropertyIsar._(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      image: entity.image,
      finishing: entity.finishing,
      minUnitArea: entity.minUnitArea,
      maxUnitArea: entity.maxUnitArea,
      minPrice: entity.minPrice,
      maxPrice: entity.maxPrice,
      currency: entity.currency,
      maxInstallmentYears: entity.maxInstallmentYears,
      maxInstallmentYearsMonths: entity.maxInstallmentYearsMonths,
      isFavorite: entity.isFavorite,
      propertyTypeId: entity.propertyType?.id,
      areaId: entity.area?.id,
      developerId: entity.developer?.id,
      compoundId: entity.compound?.id,
    );
  }
}
