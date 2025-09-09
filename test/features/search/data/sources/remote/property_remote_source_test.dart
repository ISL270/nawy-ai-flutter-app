import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/property_type_dto.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';

/// Test version of PropertyRemoteSource that uses in-memory data instead of assets
class TestPropertyRemoteSource {
  final SearchResponse _testSearchResponse;

  TestPropertyRemoteSource(this._testSearchResponse);

  Future<List<AreaDto>> getAreas() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final Map<int, String> uniqueAreas = <int, String>{};

        // Extract unique areas with their actual names from properties
        for (final property in _testSearchResponse.properties) {
          if (property.area?.id != null && property.area?.name != null) {
            uniqueAreas[property.area!.id] = property.area!.name;
          }
        }

        // Create area DTOs with actual names
        return uniqueAreas.entries
            .map((entry) => AreaDto(id: entry.key, name: entry.value))
            .toList();
      },
      const Duration(seconds: 10),
      'GetAreas',
    );
  }

  Future<List<CompoundDto>> getCompounds() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final Map<int, CompoundDto> uniqueCompounds = <int, CompoundDto>{};

        // Extract unique compounds with their actual names from properties
        for (final property in _testSearchResponse.properties) {
          if (property.compound?.id != null && property.compound?.name != null) {
            uniqueCompounds[property.compound!.id] = CompoundDto(
              id: property.compound!.id,
              name: property.compound!.name,
              areaId: property.area?.id ?? 1, // Use actual area ID or fallback
            );
          }
        }

        // Return list of compound DTOs with actual names
        return uniqueCompounds.values.toList();
      },
      const Duration(seconds: 10),
      'GetCompounds',
    );
  }

  Future<FilterOptions> getFilterOptions() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final properties = _testSearchResponse.properties;

        // Extract unique property types from the properties
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

        // Calculate price range from the properties
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
    return await ErrorHandler.executeWithTimeout(
      () async {
        List<dynamic> filteredProperties = List.from(_testSearchResponse.properties);

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
          totalCompounds: _testSearchResponse.totalCompounds,
          totalProperties: filteredProperties.length,
          totalPropertyGroups: _testSearchResponse.totalPropertyGroups,
          propertyTypes: _testSearchResponse.propertyTypes,
          properties: filteredProperties.cast(),
        );
      },
      const Duration(seconds: 30),
      'SearchProperties',
    );
  }
}

/// PropertyRemoteSource Tests
/// Validates local data loading and filtering functionality with mock asset data
void main() {
  group('PropertyRemoteSource Tests', () {
    late TestPropertyRemoteSource remoteSource;
    late AppLogger appLogger;

    setUpAll(() {
      // Initialize Flutter test environment
      TestWidgetsFlutterBinding.ensureInitialized();

      // Initialize AppLogger for error handling
      appLogger = AppLogger();
      appLogger.initialize();
    });

    setUp(() {
      // Create test search response with mock data
      final testSearchResponse = _createTestSearchResponse();
      remoteSource = TestPropertyRemoteSource(testSearchResponse);
    });

    group('getAreas', () {
      test('should return list of unique areas from local data', () async {
        // Act
        final result = await remoteSource.getAreas();

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, equals(4)); // 4 unique areas in mock data
        expect(result.first.id, isA<int>());
        expect(result.first.name, isA<String>());

        // Verify areas are unique
        final areaIds = result.map((area) => area.id).toSet();
        expect(areaIds.length, equals(result.length));

        // Verify specific areas from mock data
        final areaNames = result.map((area) => area.name).toSet();
        expect(areaNames, contains('El Sheikh Zayed'));
        expect(areaNames, contains('Mostakbal City'));
        expect(areaNames, contains('New Cairo'));
        expect(areaNames, contains('North Coast'));
      });
    });

    group('getCompounds', () {
      test('should return list of unique compounds from local data', () async {
        // Act
        final result = await remoteSource.getCompounds();

        // Assert
        expect(result, isNotEmpty);
        expect(result.length, equals(5)); // 5 unique compounds in mock data
        expect(result.first.id, isA<int>());
        expect(result.first.name, isA<String>());
        expect(result.first.areaId, isA<int>());

        // Verify compounds are unique
        final compoundIds = result.map((compound) => compound.id).toSet();
        expect(compoundIds.length, equals(result.length));

        // Verify specific compounds from mock data
        final compoundNames = result.map((compound) => compound.name).toSet();
        expect(compoundNames, contains('ZED West'));
        expect(compoundNames, contains('Bloomfields'));
        expect(compoundNames, contains('Cairo Festival City'));
        expect(compoundNames, contains('Compound X'));
        expect(compoundNames, contains('Hacienda Bay'));
      });
    });

    group('searchProperties', () {
      test('should return filtered search response with properties', () async {
        // Act - Test with area filter
        final allProperties = await remoteSource.searchProperties();
        final filteredByArea = await remoteSource.searchProperties(areaIds: [1]);

        // Assert
        expect(allProperties.properties, isNotEmpty);
        expect(allProperties.totalProperties, equals(5)); // 5 properties in mock data
        expect(allProperties.properties.length, equals(5));

        // Filtered results should be less than or equal to all results
        expect(
          filteredByArea.properties.length,
          lessThanOrEqualTo(allProperties.properties.length),
        );
        expect(
          filteredByArea.properties.length,
          equals(2),
        ); // 2 properties in area 1 (El Sheikh Zayed)

        // All filtered properties should have the specified area ID
        for (final property in filteredByArea.properties) {
          expect(property.area?.id, equals(1));
        }
      });

      test('should handle empty search parameters and return all properties', () async {
        // Act
        final result = await remoteSource.searchProperties();

        // Assert
        expect(result.properties, isNotEmpty);
        expect(result.totalProperties, equals(5)); // 5 properties in mock data
        expect(result.properties.length, equals(5));
        expect(result.properties.first.id, isA<int>());
        expect(result.properties.first.name, isA<String>());

        // Verify specific properties from mock data
        final propertyNames = result.properties.map((p) => p.name).toList();
        expect(propertyNames, contains('Luxury Apartment in ZED'));
        expect(propertyNames, contains('Modern Villa in Bloomfields'));
      });

      test('should handle null and empty list parameters correctly', () async {
        // Act - Empty lists and null values should return all properties
        final result = await remoteSource.searchProperties(
          areaIds: [], // Empty list
          compoundIds: null, // Null
          propertyTypeIds: [], // Empty list
        );

        // Assert - Should return all properties when no filters applied
        expect(result.properties, isNotEmpty);
        expect(result.totalProperties, equals(5)); // 5 properties in mock data
        expect(result.properties.length, equals(5));
      });

      test('should filter by price range correctly', () async {
        // Act
        final allProperties = await remoteSource.searchProperties();
        final filteredProperties = await remoteSource.searchProperties(
          minPrice: 2000000,
          maxPrice: 8000000,
        );

        // Assert
        expect(allProperties.properties.length, equals(5));
        expect(
          filteredProperties.properties.length,
          lessThanOrEqualTo(allProperties.properties.length),
        );
        expect(
          filteredProperties.properties.length,
          equals(2),
        ); // Properties 1 and 5 match this range

        // All filtered properties should be within price range
        for (final property in filteredProperties.properties) {
          expect(property.minPrice, greaterThanOrEqualTo(2000000));
          expect(property.maxPrice, lessThanOrEqualTo(8000000));
        }
      });

      test('should filter by bedroom count correctly', () async {
        // Act
        final allProperties = await remoteSource.searchProperties();
        final filteredProperties = await remoteSource.searchProperties(
          minBedrooms: 2,
          maxBedrooms: 4,
        );

        // Assert
        expect(allProperties.properties.length, equals(5));
        expect(
          filteredProperties.properties.length,
          lessThanOrEqualTo(allProperties.properties.length),
        );
        expect(
          filteredProperties.properties.length,
          equals(3),
        ); // Properties 1, 2, and 5 have 2-4 bedrooms

        // All filtered properties should be within bedroom range
        for (final property in filteredProperties.properties) {
          if (property.numberOfBedrooms != null) {
            expect(property.numberOfBedrooms!, greaterThanOrEqualTo(2));
            expect(property.numberOfBedrooms!, lessThanOrEqualTo(4));
          }
        }
      });
    });

    group('getFilterOptions', () {
      test('should return filter options based on local data', () async {
        // Act
        final result = await remoteSource.getFilterOptions();

        // Assert
        expect(result.minBedrooms, equals(0));
        expect(result.maxBedrooms, equals(6));
        expect(result.minBedrooms, lessThanOrEqualTo(result.maxBedrooms));
        expect(result.minPriceList, isNotEmpty);
        expect(result.maxPriceList, isNotEmpty);
        expect(result.propertyTypes, isNotEmpty);
        expect(result.propertyTypes!.length, equals(3)); // 3 property types in mock data

        // Verify property types have required fields and specific values
        final propertyTypeNames = result.propertyTypes!.map((pt) => pt.name).toSet();
        expect(propertyTypeNames, contains('Apartment'));
        expect(propertyTypeNames, contains('Villa'));
        expect(propertyTypeNames, contains('Chalet'));

        for (final propertyType in result.propertyTypes!) {
          expect(propertyType.id, isA<int>());
          expect(propertyType.name, isA<String>());
        }
      });
    });

    group('Data Consistency', () {
      test('should return consistent data across multiple calls', () async {
        // Act
        final areas1 = await remoteSource.getAreas();
        final areas2 = await remoteSource.getAreas();

        final compounds1 = await remoteSource.getCompounds();
        final compounds2 = await remoteSource.getCompounds();

        final filterOptions1 = await remoteSource.getFilterOptions();
        final filterOptions2 = await remoteSource.getFilterOptions();

        // Assert - Data should be consistent across calls (cached)
        expect(areas1.length, equals(areas2.length));
        expect(areas1.length, equals(4)); // 4 unique areas
        expect(compounds1.length, equals(compounds2.length));
        expect(compounds1.length, equals(5)); // 5 unique compounds
        expect(filterOptions1.minBedrooms, equals(filterOptions2.minBedrooms));
        expect(filterOptions1.maxBedrooms, equals(filterOptions2.maxBedrooms));
      });

      test('should have valid relationships between data', () async {
        // Act
        final areas = await remoteSource.getAreas();
        final compounds = await remoteSource.getCompounds();
        final properties = await remoteSource.searchProperties();

        // Assert - All compounds should reference valid areas
        final areaIds = areas.map((area) => area.id).toSet();
        expect(areaIds, equals({1, 2, 3, 4})); // Expected area IDs from mock data

        for (final compound in compounds) {
          expect(areaIds, contains(compound.areaId));
        }

        // All properties should have valid areas and compounds
        final compoundIds = compounds.map((compound) => compound.id).toSet();
        expect(compoundIds, equals({1, 2, 3, 4, 5})); // Expected compound IDs from mock data

        for (final property in properties.properties) {
          if (property.area?.id != null) {
            expect(areaIds, contains(property.area!.id));
          }
          if (property.compound?.id != null) {
            expect(compoundIds, contains(property.compound!.id));
          }
        }
      });

      test('should filter by property type correctly', () async {
        // Act - Filter by Apartment type (id: 1)
        final allProperties = await remoteSource.searchProperties();
        final apartmentProperties = await remoteSource.searchProperties(propertyTypeIds: [1]);

        // Assert
        expect(allProperties.properties.length, equals(5));
        expect(
          apartmentProperties.properties.length,
          equals(2),
        ); // Properties 1 and 3 are apartments

        // All filtered properties should be apartments
        for (final property in apartmentProperties.properties) {
          expect(property.propertyType?.id, equals(1));
          expect(property.propertyType?.name, equals('Apartment'));
        }
      });

      test('should handle multiple filters simultaneously', () async {
        // Act - Filter by area 1 (El Sheikh Zayed) and Villa type (id: 2)
        final filteredProperties = await remoteSource.searchProperties(
          areaIds: [1],
          propertyTypeIds: [2],
        );

        // Assert - Should return property 4 (Spacious Villa in Compound X)
        expect(filteredProperties.properties.length, equals(1));
        expect(filteredProperties.properties.first.name, equals('Spacious Villa in Compound X'));
        expect(filteredProperties.properties.first.area?.id, equals(1));
        expect(filteredProperties.properties.first.propertyType?.id, equals(2));
      });
    });
  });
}

/// Creates test search response with mock data for testing
SearchResponse _createTestSearchResponse() {
  const String mockPropertiesJson = '''
{
  "total_compounds": 5,
  "total_properties": 5,
  "total_property_groups": 3,
  "property_types": [
    {
      "id": 1,
      "name": "Apartment",
      "count": 2
    },
    {
      "id": 2,
      "name": "Villa",
      "count": 2
    },
    {
      "id": 3,
      "name": "Chalet",
      "count": 1
    }
  ],
  "values": [
    {
      "id": 1,
      "name": "Luxury Apartment in ZED",
      "min_price": 2500000,
      "max_price": 3500000,
      "number_of_bedrooms": 2,
      "number_of_bathrooms": 2,
      "area": {
        "id": 1,
        "name": "El Sheikh Zayed"
      },
      "compound": {
        "id": 1,
        "name": "ZED West"
      },
      "property_type": {
        "id": 1,
        "name": "Apartment"
      },
      "new_property": true,
      "has_offers": false,
      "images": ["https://example.com/image1.jpg"]
    },
    {
      "id": 2,
      "name": "Modern Villa in Bloomfields",
      "min_price": 8000000,
      "max_price": 12000000,
      "number_of_bedrooms": 4,
      "number_of_bathrooms": 3,
      "area": {
        "id": 2,
        "name": "Mostakbal City"
      },
      "compound": {
        "id": 2,
        "name": "Bloomfields"
      },
      "property_type": {
        "id": 2,
        "name": "Villa"
      },
      "new_property": false,
      "has_offers": true,
      "images": ["https://example.com/image2.jpg"]
    },
    {
      "id": 3,
      "name": "Cozy Apartment in New Cairo",
      "min_price": 1800000,
      "max_price": 2200000,
      "number_of_bedrooms": 1,
      "number_of_bathrooms": 1,
      "area": {
        "id": 3,
        "name": "New Cairo"
      },
      "compound": {
        "id": 3,
        "name": "Cairo Festival City"
      },
      "property_type": {
        "id": 1,
        "name": "Apartment"
      },
      "new_property": true,
      "has_offers": false,
      "images": ["https://example.com/image3.jpg"]
    },
    {
      "id": 4,
      "name": "Spacious Villa in Compound X",
      "min_price": 15000000,
      "max_price": 18000000,
      "number_of_bedrooms": 5,
      "number_of_bathrooms": 4,
      "area": {
        "id": 1,
        "name": "El Sheikh Zayed"
      },
      "compound": {
        "id": 4,
        "name": "Compound X"
      },
      "property_type": {
        "id": 2,
        "name": "Villa"
      },
      "new_property": false,
      "has_offers": true,
      "images": ["https://example.com/image4.jpg"]
    },
    {
      "id": 5,
      "name": "Beach Chalet in North Coast",
      "min_price": 5000000,
      "max_price": 7000000,
      "number_of_bedrooms": 3,
      "number_of_bathrooms": 2,
      "area": {
        "id": 4,
        "name": "North Coast"
      },
      "compound": {
        "id": 5,
        "name": "Hacienda Bay"
      },
      "property_type": {
        "id": 3,
        "name": "Chalet"
      },
      "new_property": true,
      "has_offers": false,
      "images": ["https://example.com/image5.jpg"]
    }
  ]
}
''';

  final Map<String, dynamic> jsonData = json.decode(mockPropertiesJson);
  return SearchResponse.fromJson(jsonData);
}
