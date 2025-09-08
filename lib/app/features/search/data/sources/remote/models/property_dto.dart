import 'package:json_annotation/json_annotation.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/developer_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/property_type_dto.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';

part 'property_dto.g.dart';

/// API model for Property - handles JSON serialization from API
@JsonSerializable()
class PropertyDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'property_type')
  final PropertyTypeDto? propertyType;

  @JsonKey(name: 'compound')
  final PropertyCompoundDto? compound;

  @JsonKey(name: 'area')
  final AreaDto? area;

  @JsonKey(name: 'developer')
  final DeveloperDto? developer;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'finishing')
  final String? finishing;

  @JsonKey(name: 'min_unit_area')
  final double? minUnitArea;

  @JsonKey(name: 'max_unit_area')
  final double? maxUnitArea;

  @JsonKey(name: 'min_price')
  final double? minPrice;

  @JsonKey(name: 'max_price')
  final double? maxPrice;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'max_installment_years')
  final int? maxInstallmentYears;

  @JsonKey(name: 'max_installment_years_months')
  final String? maxInstallmentYearsMonths;

  @JsonKey(name: 'min_installments')
  final int? minInstallments;

  @JsonKey(name: 'min_down_payment')
  final int? minDownPayment;

  @JsonKey(name: 'number_of_bathrooms')
  final int? numberOfBathrooms;

  @JsonKey(name: 'number_of_bedrooms')
  final int? numberOfBedrooms;

  @JsonKey(name: 'min_ready_by')
  final String? minReadyBy;

  @JsonKey(name: 'sponsored')
  final int? sponsored;

  @JsonKey(name: 'new_property')
  final bool? newProperty;

  @JsonKey(name: 'resale')
  final bool? resale;

  @JsonKey(name: 'financing')
  final bool? financing;

  @JsonKey(name: 'has_offers')
  final bool? hasOffers;

  @JsonKey(name: 'offer_title')
  final String? offerTitle;

  @JsonKey(name: 'limited_time_offer')
  final bool? limitedTimeOffer;

  @JsonKey(name: 'favorite')
  final bool? favorite;

  @JsonKey(name: 'ranking_type')
  final String? rankingType;

  @JsonKey(name: 'recommended_financing')
  final int? recommendedFinancing;

  @JsonKey(name: 'property_ranking')
  final double? propertyRanking;

  @JsonKey(name: 'compound_ranking')
  final int? compoundRanking;

  @JsonKey(name: 'tags')
  final List<dynamic>? tags;

  const PropertyDto({
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
    this.minInstallments,
    this.minDownPayment,
    this.numberOfBathrooms,
    this.numberOfBedrooms,
    this.minReadyBy,
    this.sponsored,
    this.newProperty,
    this.resale,
    this.financing,
    this.hasOffers,
    this.offerTitle,
    this.limitedTimeOffer,
    this.favorite,
    this.rankingType,
    this.recommendedFinancing,
    this.propertyRanking,
    this.compoundRanking,
    this.tags,
  });

  factory PropertyDto.fromJson(Map<String, dynamic> json) => _$PropertyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDtoToJson(this);

  /// Convert API model to domain entity
  Property toEntity() {
    return Property(
      id: id,
      name: name,
      slug: slug,
      propertyType: propertyType?.toEntity(),
      compound: compound?.toEntity(),
      area: area?.toEntity(),
      developer: developer?.toEntity(),
      image: image,
      finishing: finishing,
      minUnitArea: minUnitArea,
      maxUnitArea: maxUnitArea,
      minPrice: minPrice,
      maxPrice: maxPrice,
      currency: currency,
      maxInstallmentYears: maxInstallmentYears,
      maxInstallmentYearsMonths: maxInstallmentYearsMonths,
      minInstallments: minInstallments,
      minDownPayment: minDownPayment,
      numberOfBathrooms: numberOfBathrooms,
      numberOfBedrooms: numberOfBedrooms,
      minReadyBy: minReadyBy,
      sponsored: sponsored,
      newProperty: newProperty ?? false,
      resale: resale ?? false,
      financing: financing ?? false,
      hasOffers: hasOffers ?? false,
      offerTitle: offerTitle,
      limitedTimeOffer: limitedTimeOffer ?? false,
      rankingType: rankingType,
      recommendedFinancing: recommendedFinancing,
      propertyRanking: propertyRanking,
      compoundRanking: compoundRanking,
      tags: tags,
      isFavorite: favorite ?? false, // Use API favorite or default to false
    );
  }

  /// Create API model from domain entity
  factory PropertyDto.fromEntity(Property entity) {
    return PropertyDto(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      propertyType: entity.propertyType != null
          ? PropertyTypeDto.fromEntity(entity.propertyType!)
          : null,
      compound: entity.compound != null ? PropertyCompoundDto.fromEntity(entity.compound!) : null,
      area: entity.area != null ? AreaDto.fromEntity(entity.area!) : null,
      developer: entity.developer != null ? DeveloperDto.fromEntity(entity.developer!) : null,
      image: entity.image,
      finishing: entity.finishing,
      minUnitArea: entity.minUnitArea,
      maxUnitArea: entity.maxUnitArea,
      minPrice: entity.minPrice,
      maxPrice: entity.maxPrice,
      currency: entity.currency,
      maxInstallmentYears: entity.maxInstallmentYears,
      maxInstallmentYearsMonths: entity.maxInstallmentYearsMonths,
      minInstallments: entity.minInstallments,
      minDownPayment: entity.minDownPayment,
      numberOfBathrooms: entity.numberOfBathrooms,
      numberOfBedrooms: entity.numberOfBedrooms,
      minReadyBy: entity.minReadyBy,
      sponsored: entity.sponsored,
      newProperty: entity.newProperty,
      resale: entity.resale,
      financing: entity.financing,
      hasOffers: entity.hasOffers,
      offerTitle: entity.offerTitle,
      limitedTimeOffer: entity.limitedTimeOffer,
      favorite: entity.isFavorite,
      rankingType: entity.rankingType,
      recommendedFinancing: entity.recommendedFinancing,
      propertyRanking: entity.propertyRanking,
      compoundRanking: entity.compoundRanking,
      tags: entity.tags,
    );
  }
}

@JsonSerializable()
class PropertyCompoundDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'lat')
  final double? lat;

  @JsonKey(name: 'long')
  final double? long;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'sponsored')
  final int? sponsored;

  @JsonKey(name: 'nawy_organization_id')
  final int? nawyOrganizationId;

  const PropertyCompoundDto({
    required this.id,
    required this.name,
    this.lat,
    this.long,
    this.slug,
    this.sponsored,
    this.nawyOrganizationId,
  });

  factory PropertyCompoundDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyCompoundDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyCompoundDtoToJson(this);

  /// Convert API model to domain entity
  PropertyCompound toEntity() {
    return PropertyCompound(
      id: id,
      name: name,
      latitude: lat,
      longitude: long,
      slug: slug,
      sponsored: sponsored,
      nawyOrganizationId: nawyOrganizationId,
    );
  }

  /// Create API model from domain entity
  factory PropertyCompoundDto.fromEntity(PropertyCompound entity) {
    return PropertyCompoundDto(
      id: entity.id,
      name: entity.name,
      lat: entity.latitude,
      long: entity.longitude,
      slug: entity.slug,
      sponsored: entity.sponsored,
      nawyOrganizationId: entity.nawyOrganizationId,
    );
  }
}
