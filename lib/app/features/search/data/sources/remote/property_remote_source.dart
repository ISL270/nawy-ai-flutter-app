import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
// import 'package:nawy_app/app/core/constants/api_constants.dart'; // Commented out for demo
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/property_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/property_type_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';

/// IMPORTANT NOTE:
/// The original API endpoints don't work as expected for a proper demo:
/// - Properties search always returns the same 12 static properties regardless of filters
/// - No server-side filtering or pagination is implemented
/// - All query parameters are ignored by the static JSON files
/// This is why we implemented this workaround using local data to demonstrate
/// proper search and filtering functionality that would work with a real API.

@singleton
class PropertyRemoteSource {
  // final DioClient _dioClient; // Commented out for demo - keeping for production use

  // Cache for the local data loaded from properties.json
  SearchResponse? _cachedSearchResponse;

  PropertyRemoteSource(DioClient dioClient); // Keep parameter for dependency injection

  /// Loads the search response from local JSON file
  /// This is a workaround because the original API doesn't work as expected:
  /// - Always returns the same 12 properties regardless of search filters
  /// - Ignores all query parameters (area, compound, price, bedrooms, etc.)
  /// - No server-side filtering or pagination functionality
  /// In production, this would be replaced with a properly functioning API
  Future<SearchResponse> _loadSearchResponseFromLocal() async {
    if (_cachedSearchResponse != null) {
      return _cachedSearchResponse!;
    }

    final String jsonString = await rootBundle.loadString('properties.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    _cachedSearchResponse = SearchResponse.fromJson(jsonData);
    return _cachedSearchResponse!;
  }

  Future<List<AreaDto>> getAreas() async {
    // ORIGINAL NETWORK IMPLEMENTATION (commented out - API doesn't work as expected)
    // The API serves static JSON files that ignore all query parameters and filters
    // Always returns the same data regardless of search criteria
    /*
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.areas);
        final List<dynamic> data = response.data;
        return data.map((json) => AreaDto.fromJson(json)).toList();
      },
      const Duration(seconds: 10),
      'GetAreas',
    );
    */

    // DEMO IMPLEMENTATION: Extract unique areas from the 100 properties
    return await ErrorHandler.executeWithTimeout(
      () async {
        final searchResponse = await _loadSearchResponseFromLocal();
        final Set<int> uniqueAreaIds = searchResponse.properties
            .map((p) => p.area?.id)
            .where((id) => id != null)
            .cast<int>()
            .toSet();

        // Create area DTOs based on the areas found in properties
        return uniqueAreaIds.map((areaId) => AreaDto(id: areaId, name: 'Area $areaId')).toList();
      },
      const Duration(seconds: 10),
      'GetAreas',
    );
  }

  Future<List<CompoundDto>> getCompounds() async {
    // ORIGINAL NETWORK IMPLEMENTATION (commented out - API doesn't work as expected)
    // The API returns 925 static compounds but ignores all filtering parameters
    // No server-side filtering capability, always returns the same full list
    /*
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.compounds);
        final List<dynamic> data = response.data;
        return data.map((json) => CompoundDto.fromJson(json)).toList();
      },
      const Duration(seconds: 10),
      'GetCompounds',
    );
    */

    // DEMO IMPLEMENTATION: Only return compounds referenced by the 100 properties
    return await ErrorHandler.executeWithTimeout(
      () async {
        final searchResponse = await _loadSearchResponseFromLocal();
        final Set<int> uniqueCompoundIds = searchResponse.properties
            .map((p) => p.compound?.id)
            .where((id) => id != null)
            .cast<int>()
            .toSet();

        // Create compound DTOs based on the compounds found in properties
        return uniqueCompoundIds
            .map(
              (compoundId) => CompoundDto(
                id: compoundId,
                name: 'Compound $compoundId',
                areaId: 1, // Required field
              ),
            )
            .toList();
      },
      const Duration(seconds: 10),
      'GetCompounds',
    );
  }

  Future<FilterOptions> getFilterOptions() async {
    // ORIGINAL NETWORK IMPLEMENTATION (commented out - API doesn't work as expected)
    // The API returns static filter options that don't reflect actual property data
    /*
    return await ErrorHandler.executeWithTimeout(
      () async {
        final response = await _dioClient.dio.get(ApiConstants.filterOptions);
        return FilterOptions.fromJson(response.data);
      },
      const Duration(seconds: 10),
      'GetFilterOptions',
    );
    */

    // DEMO IMPLEMENTATION: Generate filter options based on the 100 properties
    return await ErrorHandler.executeWithTimeout(
      () async {
        final searchResponse = await _loadSearchResponseFromLocal();
        final properties = searchResponse.properties;

        // Extract unique property types from the 100 properties
        final Set<String> uniqueTypes = properties
            .map((p) => p.propertyType?.name)
            .where((name) => name != null)
            .cast<String>()
            .toSet();

        final propertyTypes = uniqueTypes
            .map(
              (type) => PropertyTypeDto(
                id: uniqueTypes.toList().indexOf(type) + 1,
                name: type,
                icon: null, // No icon for demo
              ),
            )
            .toList();

        // Calculate price range from the 100 properties
        final prices = properties
            .map((p) => p.minPrice)
            .where((price) => price != null)
            .cast<double>()
            .toList();
        prices.sort();

        return FilterOptions(
          minPriceList: [prices.first.toInt()],
          maxPriceList: [prices.last.toInt()],
          propertyTypes: propertyTypes,
          minBedrooms: 0,
          maxBedrooms: 6,
        );
      },
      const Duration(seconds: 10),
      'GetFilterOptions',
    );
  }

  Future<SearchResponse> searchProperties({
    List<int>? areaIds,
    List<int>? compoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? propertyTypeIds,
  }) async {
    // ORIGINAL NETWORK IMPLEMENTATION (commented out - API doesn't work as expected)
    // The API always returns the same 12 static properties regardless of any filters
    // All query parameters (area_ids, compound_ids, price ranges, etc.) are completely ignored
    // No server-side search or filtering functionality is implemented
    /*
    return await ErrorHandler.executeWithTimeout(
      () async {
        // Build query parameters
        final Map<String, dynamic> queryParams = {};

        if (areaIds != null && areaIds.isNotEmpty) {
          queryParams['area_ids'] = areaIds.join(',');
        }

        if (compoundIds != null && compoundIds.isNotEmpty) {
          queryParams['compound_ids'] = compoundIds.join(',');
        }

        if (minPrice != null) {
          queryParams['min_price'] = minPrice;
        }

        if (maxPrice != null) {
          queryParams['max_price'] = maxPrice;
        }

        if (minBedrooms != null) {
          queryParams['min_bedrooms'] = minBedrooms;
        }

        if (maxBedrooms != null) {
          queryParams['max_bedrooms'] = maxBedrooms;
        }

        if (propertyTypeIds != null && propertyTypeIds.isNotEmpty) {
          queryParams['property_type_ids'] = propertyTypeIds.join(',');
        }

        final response = await _dioClient.dio.get(
          ApiConstants.propertiesSearch,
          queryParameters: queryParams,
        );

        return SearchResponse.fromJson(response.data);
      },
      const Duration(seconds: 30),
      'SearchProperties',
    );
    */

    // DEMO IMPLEMENTATION: Filter the 100 properties based on search criteria
    // This demonstrates how search and filtering would work in a real application
    return await ErrorHandler.executeWithTimeout(
      () async {
        final searchResponse = await _loadSearchResponseFromLocal();
        List<PropertyDto> filteredProperties = List.from(searchResponse.properties);

        // Apply area filter
        if (areaIds != null && areaIds.isNotEmpty) {
          filteredProperties = filteredProperties
              .where((property) => property.area?.id != null && areaIds.contains(property.area!.id))
              .toList();
        }

        // Apply compound filter
        if (compoundIds != null && compoundIds.isNotEmpty) {
          filteredProperties = filteredProperties
              .where(
                (property) =>
                    property.compound?.id != null && compoundIds.contains(property.compound!.id),
              )
              .toList();
        }

        // Apply price range filter
        if (minPrice != null) {
          filteredProperties = filteredProperties
              .where((property) => property.minPrice != null && property.minPrice! >= minPrice)
              .toList();
        }

        if (maxPrice != null) {
          filteredProperties = filteredProperties
              .where((property) => property.maxPrice != null && property.maxPrice! <= maxPrice)
              .toList();
        }

        // Apply bedroom filter
        if (minBedrooms != null) {
          filteredProperties = filteredProperties
              .where(
                (property) =>
                    property.numberOfBedrooms != null && property.numberOfBedrooms! >= minBedrooms,
              )
              .toList();
        }

        if (maxBedrooms != null) {
          filteredProperties = filteredProperties
              .where(
                (property) =>
                    property.numberOfBedrooms != null && property.numberOfBedrooms! <= maxBedrooms,
              )
              .toList();
        }

        // Apply property type filter
        if (propertyTypeIds != null && propertyTypeIds.isNotEmpty) {
          filteredProperties = filteredProperties
              .where(
                (property) =>
                    property.propertyType?.id != null &&
                    propertyTypeIds.contains(property.propertyType!.id),
              )
              .toList();
        }

        return SearchResponse(
          totalCompounds: searchResponse.totalCompounds,
          totalProperties: filteredProperties.length,
          totalPropertyGroups: searchResponse.totalPropertyGroups,
          propertyTypes: searchResponse.propertyTypes,
          properties: filteredProperties,
        );
      },
      const Duration(seconds: 30),
      'SearchProperties',
    );
  }
}
