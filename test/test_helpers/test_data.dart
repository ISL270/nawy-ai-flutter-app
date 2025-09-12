import 'package:nawy_app/app/features/property_search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/developer_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_type_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property.dart';

/// Test data factory for creating consistent test objects across test suites
class TestData {
  // Sample JSON data matching API responses
  static const Map<String, dynamic> sampleAreaJson = {
    'id': 1,
    'name': 'New Cairo',
    'slug': 'new-cairo',
    'all_slugs': {'en': 'new-cairo', 'ar': 'القاهرة-الجديدة'},
  };

  static const Map<String, dynamic> sampleDeveloperJson = {
    'id': 1,
    'name': 'Emaar Misr',
    'slug': 'emaar-misr',
    'image_path': '/images/emaar.jpg',
  };

  static const Map<String, dynamic> samplePropertyTypeJson = {
    'id': 1,
    'name': 'Apartment',
    'icon': {'url': '/images/apartment.jpg'},
    'has_land_area': false,
    'has_mandatory_garden_area': false,
    'manual_ranking': null,
  };

  static const Map<String, dynamic> sampleCompoundJson = {
    'id': 1,
    'area_id': 1,
    'developer_id': 1,
    'name': 'Madinaty',
    'slug': 'madinaty',
    'updated_at': '2024-01-15T10:30:00Z',
    'image_path': '/images/madinaty.jpg',
    'nawy_organization_id': 1,
    'has_offers': true,
    'area': sampleAreaJson,
  };

  static const Map<String, dynamic> samplePropertyJson = {
    'id': 1,
    'name': 'Luxury Apartment in Madinaty',
    'slug': 'luxury-apartment-madinaty',
    'min_price': 2500000,
    'max_price': 3000000,
    'min_area': 120,
    'max_area': 150,
    'min_bedrooms': 2,
    'max_bedrooms': 3,
    'lat': 30.0444,
    'lng': 31.2357,
    'image_path': '/images/property1.jpg',
    'updated_at': '2024-01-15T10:30:00Z',
    'area': sampleAreaJson,
    'developer': sampleDeveloperJson,
    'property_type': samplePropertyTypeJson,
    'compound': sampleCompoundJson,
    'min_installments': 60,
    'number_of_bathrooms': 2,
    'new_property': true,
    'favorite': false,
    'ranking_type': 'premium',
    'tags': ['luxury', 'new', 'compound'],
    'delivery_date': '2025-12-31',
    'finishing_type': 'fully_finished',
    'view_type': 'garden',
    'floor_number': 3,
    'total_floors': 10,
    'parking_spaces': 1,
    'balcony': true,
    'furnished': false,
    'pets_allowed': true,
    'security': true,
    'elevator': true,
    'garden': false,
    'pool': true,
    'gym': true,
    'maintenance_fee': 500,
  };

  static const Map<String, dynamic> sampleSearchResponseJson = {
    'data': [samplePropertyJson],
    'total_properties': 1250,
    'property_type_count': [
      {'property_type_id': 1, 'count': 800},
      {'property_type_id': 2, 'count': 450},
    ],
  };

  static const Map<String, dynamic> sampleFilterOptionsJson = {
    'min_bedrooms': 1,
    'max_bedrooms': 5,
    'min_price_list': [500000, 1000000, 2000000, 5000000],
    'max_price_list': [1000000, 2000000, 5000000, 10000000],
    'property_types': [samplePropertyTypeJson],
    'amenities': [
      {'id': 1, 'name': 'Swimming Pool', 'image_path': '/images/pool.jpg'},
    ],
    'sortings': [
      {'key': 'price', 'value': 'Price', 'direction': 'asc'},
    ],
    'sale_types': ['sale', 'rent'],
  };

  // DTO Factory Methods
  static AreaDto createAreaDto({
    int id = 1,
    String name = 'New Cairo',
    String? slug = 'new-cairo',
    Map<String, String>? allSlugs,
  }) {
    return AreaDto(
      id: id,
      name: name,
      slug: slug,
      allSlugs: allSlugs ?? {'en': 'new-cairo', 'ar': 'القاهرة-الجديدة'},
    );
  }

  static DeveloperDto createDeveloperDto({
    int id = 1,
    String name = 'Emaar Misr',
    String? slug = 'emaar-misr',
    String? logoPath = '/images/emaar.jpg',
  }) {
    return DeveloperDto(id: id, name: name, slug: slug, logoPath: logoPath);
  }

  static PropertyCompoundDto createPropertyCompoundDto({
    int id = 1,
    String name = 'Madinaty',
    double? lat = 30.0444,
    double? long = 31.2357,
    String? slug = 'madinaty',
    int? nawyOrganizationId = 1,
  }) {
    return PropertyCompoundDto(
      id: id,
      name: name,
      lat: lat,
      long: long,
      slug: slug,
      nawyOrganizationId: nawyOrganizationId,
    );
  }

  static PropertyTypeDto createPropertyTypeDto({
    int id = 1,
    String name = 'Apartment',
    String? iconUrl = '/images/apartment.jpg',
    bool? hasLandArea = false,
    bool? hasMandatoryGardenArea = false,
    int? manualRanking,
  }) {
    return PropertyTypeDto(
      id: id,
      name: name,
      icon: iconUrl != null ? PropertyTypeIconDto(url: iconUrl) : null,
      hasLandArea: hasLandArea,
      hasMandatoryGardenArea: hasMandatoryGardenArea,
      manualRanking: manualRanking,
    );
  }

  static CompoundDto createCompoundDto({
    int id = 1,
    int areaId = 1,
    String name = 'Madinaty',
    int? developerId = 1,
    String? slug = 'madinaty',
    String? updatedAt = '2024-01-15T10:30:00Z',
    String? imagePath = '/images/madinaty.jpg',
    int? nawyOrganizationId = 1,
    bool? hasOffers = true,
    AreaDto? area,
  }) {
    return CompoundDto(
      id: id,
      areaId: areaId,
      name: name,
      developerId: developerId,
      slug: slug,
      updatedAt: updatedAt,
      imagePath: imagePath,
      nawyOrganizationId: nawyOrganizationId,
      hasOffers: hasOffers,
      area: area ?? createAreaDto(),
    );
  }

  static PropertyDto createPropertyDto({
    int id = 1,
    String name = 'Luxury Apartment in Madinaty',
    String? slug = 'luxury-apartment-madinaty',
    double? minPrice = 2500000.0,
    double? maxPrice = 3000000.0,
    double? minArea = 120.0,
    double? maxArea = 150.0,
    int? numberOfBedrooms = 2,
    String? imagePath = '/images/property1.jpg',
    AreaDto? area,
    DeveloperDto? developer,
    PropertyTypeDto? propertyType,
    CompoundDto? compound,
  }) {
    return PropertyDto(
      id: id,
      name: name,
      slug: slug,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minUnitArea: minArea,
      maxUnitArea: maxArea,
      numberOfBedrooms: numberOfBedrooms,
      image: imagePath,
      area: area ?? createAreaDto(),
      developer: developer ?? createDeveloperDto(),
      propertyType: propertyType ?? createPropertyTypeDto(),
      compound: compound != null ? createPropertyCompoundDto() : null,
      minInstallments: 60,
      numberOfBathrooms: 2,
      newProperty: true,
      favorite: false,
      rankingType: 'premium',
      tags: ['luxury', 'new', 'compound'],
    );
  }

  static PropertySearchResponse createSearchResponse({
    List<PropertyDto>? properties,
    int totalProperties = 1250,
    List<PropertyTypeCount>? propertyTypeCounts,
  }) {
    return PropertySearchResponse(
      properties: properties ?? [createPropertyDto()],
      totalProperties: totalProperties,
      totalCompounds: 50,
      totalPropertyGroups: 25,
      propertyTypes:
          propertyTypeCounts ??
          [PropertyTypeCount(id: 1, count: 800), PropertyTypeCount(id: 2, count: 450)],
    );
  }

  static FilterOptions createFilterOptions({
    int minBedrooms = 1,
    int maxBedrooms = 5,
    List<int>? minPriceList,
    List<int>? maxPriceList,
    List<PropertyTypeDto>? propertyTypes,
    List<Amenity>? amenities,
    List<SortOption>? sortings,
    List<String>? saleTypes,
  }) {
    return FilterOptions(
      minBedrooms: minBedrooms,
      maxBedrooms: maxBedrooms,
      minPriceList: minPriceList ?? [500000, 1000000, 2000000, 5000000],
      maxPriceList: maxPriceList ?? [1000000, 2000000, 5000000, 10000000],
      propertyTypes: propertyTypes ?? [createPropertyTypeDto()],
      amenities:
          amenities ?? [Amenity(id: 1, name: 'Swimming Pool', imagePath: '/images/pool.jpg')],
      sortings: sortings ?? [SortOption(key: 'price', value: 'Price', direction: 'asc')],
      saleTypes: saleTypes ?? ['sale', 'rent'],
    );
  }

  // Domain Entity Factory Methods
  static Area createArea({
    int id = 1,
    String name = 'New Cairo',
    String? slug = 'new-cairo',
    Map<String, String>? translations,
  }) {
    return Area(
      id: id,
      name: name,
      slug: slug,
      translations: translations ?? {'en': 'new-cairo', 'ar': 'القاهرة-الجديدة'},
    );
  }

  static Compound createCompound({
    int id = 1,
    int areaId = 1,
    String name = 'Madinaty',
    String? slug = 'madinaty',
    String? imagePath = '/images/madinaty.jpg',
    int? developerId = 1,
    DateTime? updatedAt,
    int? nawyOrganizationId = 1,
    bool hasOffers = true,
    Area? area,
    bool isFavorite = false,
  }) {
    return Compound(
      id: id,
      areaId: areaId,
      name: name,
      slug: slug,
      imagePath: imagePath,
      developerId: developerId,
      updatedAt: updatedAt ?? DateTime.parse('2024-01-15T10:30:00Z'),
      nawyOrganizationId: nawyOrganizationId,
      hasOffers: hasOffers,
      area: area ?? createArea(),
      isFavorite: isFavorite,
    );
  }

  static Property createProperty({
    int id = 1,
    String name = 'Luxury Apartment in Madinaty',
    String? slug = 'luxury-apartment-madinaty',
    double? minPrice = 2500000.0,
    double? maxPrice = 3000000.0,
    double? minUnitArea = 120.0,
    double? maxUnitArea = 150.0,
    int? numberOfBedrooms = 2,
    String? image = '/images/property1.jpg',
    bool isFavorite = false,
  }) {
    return Property(
      id: id,
      name: name,
      slug: slug,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minUnitArea: minUnitArea,
      maxUnitArea: maxUnitArea,
      numberOfBedrooms: numberOfBedrooms,
      image: image,
      isFavorite: isFavorite,
      minInstallments: 60,
      numberOfBathrooms: 2,
      newProperty: true,
      rankingType: 'premium',
      tags: ['luxury', 'new', 'compound'],
    );
  }

  // Error scenarios for testing
  static Map<String, dynamic> createMalformedPropertyJson() {
    return {
      'id': 'not-a-number', // Invalid type
      'name': null, // Required field is null
      'min_price': 'invalid-price', // Invalid type
    };
  }

  static Map<String, dynamic> createIncompletePropertyJson() {
    return {
      'id': 1,
      // Missing required fields like name, min_price, max_price
    };
  }

  // Query parameter helpers
  static Map<String, dynamic> createSearchQueryParams({
    List<int>? areaIds,
    List<int>? compoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? propertyTypeIds,
  }) {
    final params = <String, dynamic>{};

    if (areaIds != null && areaIds.isNotEmpty) {
      params['area_ids'] = areaIds;
    }
    if (compoundIds != null && compoundIds.isNotEmpty) {
      params['compound_ids'] = compoundIds;
    }
    if (minPrice != null) {
      params['min_price'] = minPrice;
    }
    if (maxPrice != null) {
      params['max_price'] = maxPrice;
    }
    if (minBedrooms != null) {
      params['min_bedrooms'] = minBedrooms;
    }
    if (maxBedrooms != null) {
      params['max_bedrooms'] = maxBedrooms;
    }
    if (propertyTypeIds != null && propertyTypeIds.isNotEmpty) {
      params['property_type_ids'] = propertyTypeIds;
    }

    return params;
  }
}
