import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_source.dart';

class MockDioClient extends Mock implements DioClient {}

/// PropertyRemoteSource Tests
/// Validates local data loading and filtering functionality
void main() {
  group('PropertyRemoteSource Tests', () {
    late PropertyRemoteSource remoteSource;
    late MockDioClient mockDioClient;

    setUpAll(() {
      // Mock the asset loading for tests
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      mockDioClient = MockDioClient();
      remoteSource = PropertyRemoteSource(mockDioClient);
    });

    group('getAreas', () {
      test('should return list of unique areas from local data', () async {
        // Act
        final result = await remoteSource.getAreas();

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.id, isA<int>());
        expect(result.first.name, isA<String>());
        
        // Verify areas are unique
        final areaIds = result.map((area) => area.id).toSet();
        expect(areaIds.length, equals(result.length));
      });
    });

    group('getCompounds', () {
      test('should return list of unique compounds from local data', () async {
        // Act
        final result = await remoteSource.getCompounds();

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.id, isA<int>());
        expect(result.first.name, isA<String>());
        expect(result.first.areaId, isA<int>());
        
        // Verify compounds are unique
        final compoundIds = result.map((compound) => compound.id).toSet();
        expect(compoundIds.length, equals(result.length));
      });
    });

    group('searchProperties', () {
      test('should return filtered search response with properties', () async {
        // Act - Test with area filter
        final allProperties = await remoteSource.searchProperties();
        final filteredByArea = await remoteSource.searchProperties(areaIds: [1]);

        // Assert
        expect(allProperties.properties, isNotEmpty);
        expect(allProperties.totalProperties, greaterThan(0));
        
        // Filtered results should be less than or equal to all results
        expect(filteredByArea.properties.length, lessThanOrEqualTo(allProperties.properties.length));
        
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
        expect(result.totalProperties, greaterThan(0));
        expect(result.properties.first.id, isA<int>());
        expect(result.properties.first.name, isA<String>());
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
        expect(result.totalProperties, greaterThan(0));
      });
      
      test('should filter by price range correctly', () async {
        // Act
        final allProperties = await remoteSource.searchProperties();
        final filteredProperties = await remoteSource.searchProperties(
          minPrice: 1000000,
          maxPrice: 5000000,
        );

        // Assert
        expect(filteredProperties.properties.length, lessThanOrEqualTo(allProperties.properties.length));
        
        // All filtered properties should be within price range
        for (final property in filteredProperties.properties) {
          expect(property.minPrice, greaterThanOrEqualTo(1000000));
          expect(property.maxPrice, lessThanOrEqualTo(5000000));
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
        expect(filteredProperties.properties.length, lessThanOrEqualTo(allProperties.properties.length));
        
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
        expect(result.minBedrooms, isA<int>());
        expect(result.maxBedrooms, isA<int>());
        expect(result.minBedrooms, lessThanOrEqualTo(result.maxBedrooms));
        expect(result.minPriceList, isNotEmpty);
        expect(result.maxPriceList, isNotEmpty);
        expect(result.propertyTypes, isNotEmpty);
        
        // Verify property types have required fields
        if (result.propertyTypes != null) {
          for (final propertyType in result.propertyTypes!) {
            expect(propertyType.id, isA<int>());
            expect(propertyType.name, isA<String>());
          }
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
        expect(compounds1.length, equals(compounds2.length));
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
        for (final compound in compounds) {
          expect(areaIds, contains(compound.areaId));
        }
        
        // All properties should have valid areas and compounds
        final compoundIds = compounds.map((compound) => compound.id).toSet();
        for (final property in properties.properties) {
          if (property.area?.id != null) {
            expect(areaIds, contains(property.area!.id));
          }
          if (property.compound?.id != null) {
            expect(compoundIds, contains(property.compound!.id));
          }
        }
      });
    });
  });
}
