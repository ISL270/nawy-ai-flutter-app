import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/developer.dart';
import 'package:nawy_app/app/features/search/domain/models/property_type.dart';

/// Domain entity for Property - pure business logic model
class Property extends Equatable {
  final int id;
  final String name;
  final String? slug;
  final PropertyType? propertyType;
  final PropertyCompound? compound;
  final Area? area;
  final Developer? developer;
  final String? image;
  final String? finishing;
  final double? minUnitArea;
  final double? maxUnitArea;
  final double? minPrice;
  final double? maxPrice;
  final String? currency;
  final int? maxInstallmentYears;
  final String? maxInstallmentYearsMonths;
  final bool isFavorite;

  const Property({
    required this.id,
    required this.name,
    this.slug,
    this.propertyType,
    this.compound,
    this.area,
    this.developer,
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
  });

  Property copyWith({
    int? id,
    String? name,
    String? slug,
    PropertyType? propertyType,
    PropertyCompound? compound,
    Area? area,
    Developer? developer,
    String? image,
    String? finishing,
    double? minUnitArea,
    double? maxUnitArea,
    double? minPrice,
    double? maxPrice,
    String? currency,
    int? maxInstallmentYears,
    String? maxInstallmentYearsMonths,
    bool? isFavorite,
  }) {
    return Property(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      propertyType: propertyType ?? this.propertyType,
      compound: compound ?? this.compound,
      area: area ?? this.area,
      developer: developer ?? this.developer,
      image: image ?? this.image,
      finishing: finishing ?? this.finishing,
      minUnitArea: minUnitArea ?? this.minUnitArea,
      maxUnitArea: maxUnitArea ?? this.maxUnitArea,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      currency: currency ?? this.currency,
      maxInstallmentYears: maxInstallmentYears ?? this.maxInstallmentYears,
      maxInstallmentYearsMonths: maxInstallmentYearsMonths ?? this.maxInstallmentYearsMonths,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    propertyType,
    compound,
    area,
    developer,
    image,
    finishing,
    minUnitArea,
    maxUnitArea,
    minPrice,
    maxPrice,
    currency,
    maxInstallmentYears,
    maxInstallmentYearsMonths,
    isFavorite,
  ];

  @override
  String toString() => 'Property(id: $id, name: $name, isFavorite: $isFavorite)';
}

/// Domain entity for PropertyCompound - nested compound info in properties
class PropertyCompound extends Equatable {
  final int id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String? slug;
  final int? sponsored;
  final int? nawyOrganizationId;

  const PropertyCompound({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    this.slug,
    this.sponsored,
    this.nawyOrganizationId,
  });

  @override
  List<Object?> get props => [id, name, latitude, longitude, slug, sponsored, nawyOrganizationId];

  @override
  String toString() => 'PropertyCompound(id: $id, name: $name)';
}
