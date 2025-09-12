import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/property_search_remote_source.dart';
import 'package:nawy_app/app/features/property_search/domain/property_search_repository.dart';

class MockPropertySearchRemoteSource extends Mock implements PropertySearchRemoteSource {}

/// PropertyRepository Unit Tests
/// Tests the repository layer that coordinates between remote data sources and domain layer
void main() {
  group('PropertyRepository Tests', () {
    late PropertySearchRepository repository;
    late MockPropertySearchRemoteSource mockRemoteSource;

    setUp(() {
      mockRemoteSource = MockPropertySearchRemoteSource();
      repository = PropertySearchRepository(mockRemoteSource);
    });

    group('getAreas', () {
      test('should return list of domain areas when remote source succeeds', () async {
        // Arrange
        final areaDtos = [
          AreaDto(id: 1, name: 'Cairo', slug: 'cairo'),
          AreaDto(id: 2, name: 'Alexandria', slug: 'alexandria'),
        ];

        when(() => mockRemoteSource.getAreas()).thenAnswer((_) async => areaDtos);

        // Act
        final result = await repository.getAreas();

        // Assert
        expect(result, hasLength(2));
        expect(result.first.id, 1);
        expect(result.first.name, 'Cairo');
        expect(result.last.id, 2);
        expect(result.last.name, 'Alexandria');
        verify(() => mockRemoteSource.getAreas()).called(1);
      });

      test('should propagate exception when remote source fails', () async {
        // Arrange
        when(() => mockRemoteSource.getAreas()).thenThrow(Exception('Network error'));

        // Act & Assert
        expect(() => repository.getAreas(), throwsA(isA<Exception>()));
        verify(() => mockRemoteSource.getAreas()).called(1);
      });

      test('should handle empty areas list', () async {
        // Arrange
        when(() => mockRemoteSource.getAreas()).thenAnswer((_) async => []);

        // Act
        final result = await repository.getAreas();

        // Assert
        expect(result, isEmpty);
        verify(() => mockRemoteSource.getAreas()).called(1);
      });
    });

    group('getCompounds', () {
      test('should return list of domain compounds when remote source succeeds', () async {
        // Arrange
        final compoundDtos = [
          CompoundDto(
            id: 1,
            name: 'Test Compound',
            areaId: 1,
            developerId: 1,
            slug: 'test-compound',
            area: AreaDto(id: 1, name: 'Cairo'),
          ),
          CompoundDto(
            id: 2,
            name: 'Another Compound',
            areaId: 2,
            developerId: 2,
            slug: 'another-compound',
            area: AreaDto(id: 2, name: 'Alexandria'),
          ),
        ];

        when(() => mockRemoteSource.getCompounds()).thenAnswer((_) async => compoundDtos);

        // Act
        final result = await repository.getCompounds();

        // Assert
        expect(result, hasLength(2));
        expect(result.first.id, 1);
        expect(result.first.name, 'Test Compound');
        expect(result.first.area?.name, 'Cairo');
        verify(() => mockRemoteSource.getCompounds()).called(1);
      });

      test('should propagate exception when remote source fails', () async {
        // Arrange
        when(() => mockRemoteSource.getCompounds()).thenThrow(Exception('API error'));

        // Act & Assert
        expect(() => repository.getCompounds(), throwsA(isA<Exception>()));
        verify(() => mockRemoteSource.getCompounds()).called(1);
      });
    });

    group('getFilterOptions', () {
      test('should return filter options when remote source succeeds', () async {
        // Arrange
        final filterOptions = FilterOptions(
          minBedrooms: 1,
          maxBedrooms: 5,
          minPriceList: [500000, 1000000, 2000000],
          maxPriceList: [1000000, 2000000, 5000000, 10000000],
          propertyTypes: [],
          amenities: [],
          sortings: [],
          saleTypes: ['sale', 'rent'],
        );

        when(() => mockRemoteSource.getFilterOptions()).thenAnswer((_) async => filterOptions);

        // Act
        final result = await repository.getFilterOptions();

        // Assert
        expect(result.minBedrooms, 1);
        expect(result.maxBedrooms, 5);
        expect(result.minPriceList, contains(500000));
        expect(result.saleTypes, contains('sale'));
        verify(() => mockRemoteSource.getFilterOptions()).called(1);
      });

      test('should propagate exception when remote source fails', () async {
        // Arrange
        when(() => mockRemoteSource.getFilterOptions()).thenThrow(Exception('Server error'));

        // Act & Assert
        expect(() => repository.getFilterOptions(), throwsA(isA<Exception>()));
        verify(() => mockRemoteSource.getFilterOptions()).called(1);
      });
    });

    group('searchProperties', () {
      test('should return search response when remote source succeeds', () async {
        // Arrange
        final searchResponse = PropertySearchResponse(
          totalCompounds: 5,
          totalProperties: 100,
          totalPropertyGroups: 10,
          properties: [
            PropertyDto(
              id: 1,
              name: 'Test Property',
              minPrice: 1000000,
              maxPrice: 2000000,
              currency: 'EGP',
            ),
          ],
        );

        when(
          () => mockRemoteSource.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          ),
        ).thenAnswer((_) async => searchResponse);

        // Act
        final result = await repository.searchProperties(
          areaIds: [1, 2],
          minPrice: 500000,
          maxPrice: 2000000,
          minBedrooms: 2,
          maxBedrooms: 4,
        );

        // Assert
        expect(result.totalProperties, 100);
        expect(result.properties, hasLength(1));
        expect(result.properties.first.name, 'Test Property');

        verify(
          () => mockRemoteSource.searchProperties(
            areaIds: [1, 2],
            compoundIds: null,
            minPrice: 500000,
            maxPrice: 2000000,
            minBedrooms: 2,
            maxBedrooms: 4,
            propertyTypeIds: null,
          ),
        ).called(1);
      });

      test('should handle search with no parameters', () async {
        // Arrange
        final searchResponse = PropertySearchResponse(
          totalCompounds: 0,
          totalProperties: 50,
          totalPropertyGroups: 0,
          properties: [],
        );

        when(() => mockRemoteSource.searchProperties()).thenAnswer((_) async => searchResponse);

        // Act
        final result = await repository.searchProperties();

        // Assert
        expect(result.totalProperties, 50);
        expect(result.properties, isEmpty);

        verify(
          () => mockRemoteSource.searchProperties(
            areaIds: null,
            compoundIds: null,
            minPrice: null,
            maxPrice: null,
            minBedrooms: null,
            maxBedrooms: null,
            propertyTypeIds: null,
          ),
        ).called(1);
      });

      test('should propagate exception when remote source fails', () async {
        // Arrange
        when(
          () => mockRemoteSource.searchProperties(areaIds: any(named: 'areaIds')),
        ).thenThrow(Exception('Search failed'));

        // Act & Assert
        expect(() => repository.searchProperties(areaIds: [1]), throwsA(isA<Exception>()));
        verify(() => mockRemoteSource.searchProperties(areaIds: [1])).called(1);
      });

      test('should pass all search parameters correctly', () async {
        // Arrange
        final searchResponse = PropertySearchResponse(
          totalCompounds: 0,
          totalProperties: 0,
          totalPropertyGroups: 0,
          properties: [],
        );

        when(
          () => mockRemoteSource.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          ),
        ).thenAnswer((_) async => searchResponse);

        // Act
        await repository.searchProperties(
          areaIds: [1, 2, 3],
          compoundIds: [10, 20],
          minPrice: 1000000,
          maxPrice: 5000000,
          minBedrooms: 3,
          maxBedrooms: 5,
          propertyTypeIds: [1, 2],
        );

        // Assert
        verify(
          () => mockRemoteSource.searchProperties(
            areaIds: [1, 2, 3],
            compoundIds: [10, 20],
            minPrice: 1000000,
            maxPrice: 5000000,
            minBedrooms: 3,
            maxBedrooms: 5,
            propertyTypeIds: [1, 2],
          ),
        ).called(1);
      });
    });

    group('Integration Tests', () {
      test('should handle multiple concurrent requests', () async {
        // Arrange
        when(() => mockRemoteSource.getAreas()).thenAnswer((_) async => []);
        when(() => mockRemoteSource.getCompounds()).thenAnswer((_) async => []);
        when(() => mockRemoteSource.getFilterOptions()).thenAnswer(
          (_) async => FilterOptions(
            minBedrooms: 1,
            maxBedrooms: 5,
            minPriceList: [500000, 1000000],
            maxPriceList: [1000000, 5000000],
            propertyTypes: [],
          ),
        );

        // Act
        final futures = await Future.wait([
          repository.getAreas(),
          repository.getCompounds(),
          repository.getFilterOptions(),
        ]);

        // Assert
        expect(futures, hasLength(3));
        verify(() => mockRemoteSource.getAreas()).called(1);
        verify(() => mockRemoteSource.getCompounds()).called(1);
        verify(() => mockRemoteSource.getFilterOptions()).called(1);
      });
    });
  });
}
