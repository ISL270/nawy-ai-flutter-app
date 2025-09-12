// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDto _$PropertyDtoFromJson(Map<String, dynamic> json) => PropertyDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String?,
  propertyType: json['property_type'] == null
      ? null
      : PropertyTypeDto.fromJson(json['property_type'] as Map<String, dynamic>),
  compound: json['compound'] == null
      ? null
      : PropertyCompoundDto.fromJson(json['compound'] as Map<String, dynamic>),
  area: json['area'] == null
      ? null
      : AreaDto.fromJson(json['area'] as Map<String, dynamic>),
  developer: json['developer'] == null
      ? null
      : DeveloperDto.fromJson(json['developer'] as Map<String, dynamic>),
  image: json['image'] as String?,
  finishing: json['finishing'] as String?,
  minUnitArea: (json['min_unit_area'] as num?)?.toDouble(),
  maxUnitArea: (json['max_unit_area'] as num?)?.toDouble(),
  minPrice: (json['min_price'] as num?)?.toDouble(),
  maxPrice: (json['max_price'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  maxInstallmentYears: (json['max_installment_years'] as num?)?.toInt(),
  maxInstallmentYearsMonths: json['max_installment_years_months'] as String?,
  minInstallments: (json['min_installments'] as num?)?.toInt(),
  minDownPayment: (json['min_down_payment'] as num?)?.toInt(),
  numberOfBathrooms: (json['number_of_bathrooms'] as num?)?.toInt(),
  numberOfBedrooms: (json['number_of_bedrooms'] as num?)?.toInt(),
  minReadyBy: json['min_ready_by'] as String?,
  sponsored: (json['sponsored'] as num?)?.toInt(),
  newProperty: json['new_property'] as bool?,
  resale: json['resale'] as bool?,
  financing: json['financing'] as bool?,
  hasOffers: json['has_offers'] as bool?,
  offerTitle: json['offer_title'] as String?,
  limitedTimeOffer: json['limited_time_offer'] as bool?,
  favorite: json['favorite'] as bool?,
  rankingType: json['ranking_type'] as String?,
  recommendedFinancing: (json['recommended_financing'] as num?)?.toInt(),
  propertyRanking: (json['property_ranking'] as num?)?.toDouble(),
  compoundRanking: (json['compound_ranking'] as num?)?.toInt(),
  tags: json['tags'] as List<dynamic>?,
);

Map<String, dynamic> _$PropertyDtoToJson(PropertyDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'property_type': instance.propertyType,
      'compound': instance.compound,
      'area': instance.area,
      'developer': instance.developer,
      'image': instance.image,
      'finishing': instance.finishing,
      'min_unit_area': instance.minUnitArea,
      'max_unit_area': instance.maxUnitArea,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'currency': instance.currency,
      'max_installment_years': instance.maxInstallmentYears,
      'max_installment_years_months': instance.maxInstallmentYearsMonths,
      'min_installments': instance.minInstallments,
      'min_down_payment': instance.minDownPayment,
      'number_of_bathrooms': instance.numberOfBathrooms,
      'number_of_bedrooms': instance.numberOfBedrooms,
      'min_ready_by': instance.minReadyBy,
      'sponsored': instance.sponsored,
      'new_property': instance.newProperty,
      'resale': instance.resale,
      'financing': instance.financing,
      'has_offers': instance.hasOffers,
      'offer_title': instance.offerTitle,
      'limited_time_offer': instance.limitedTimeOffer,
      'favorite': instance.favorite,
      'ranking_type': instance.rankingType,
      'recommended_financing': instance.recommendedFinancing,
      'property_ranking': instance.propertyRanking,
      'compound_ranking': instance.compoundRanking,
      'tags': instance.tags,
    };

PropertyCompoundDto _$PropertyCompoundDtoFromJson(Map<String, dynamic> json) =>
    PropertyCompoundDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      slug: json['slug'] as String?,
      sponsored: (json['sponsored'] as num?)?.toInt(),
      nawyOrganizationId: (json['nawy_organization_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PropertyCompoundDtoToJson(
  PropertyCompoundDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'lat': instance.lat,
  'long': instance.long,
  'name': instance.name,
  'slug': instance.slug,
  'sponsored': instance.sponsored,
  'nawy_organization_id': instance.nawyOrganizationId,
};
