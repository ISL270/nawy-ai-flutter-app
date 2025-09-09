import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/utils/dio_client.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/property_remote_source.dart';

class MockDioClient extends Mock implements DioClient {}

class MockDio extends Mock implements Dio {}

/// PropertyRemoteSource Tests
/// Validates API integration and error handling
void main() {
  group('PropertyRemoteSource Tests', () {
    late PropertyRemoteSource remoteSource;
    late MockDioClient mockDioClient;
    late MockDio mockDio;

    setUp(() {
      mockDioClient = MockDioClient();
      mockDio = MockDio();
      remoteSource = PropertyRemoteSource(mockDioClient);

      when(() => mockDioClient.dio).thenReturn(mockDio);
    });

    group('getAreas', () {
      test('should return list of areas on successful API call', () async {
        // Arrange
        final areasJson = [
          {'id': 1, 'name': 'Cairo', 'slug': 'cairo'},
          {'id': 2, 'name': 'Alexandria', 'slug': 'alexandria'},
        ];

        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: areasJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await remoteSource.getAreas();

        // Assert
        expect(result, hasLength(2));
        expect(result.first.name, 'Cairo');
        expect(result.last.name, 'Alexandria');
        verify(() => mockDio.get('/areas.json')).called(1);
      });

      test('should throw exception on API error', () async {
        // Arrange
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(() => remoteSource.getAreas(), throwsA(isA<Exception>()));
      });
    });

    group('getCompounds', () {
      test('should return list of compounds on successful API call', () async {
        // Arrange
        final compoundsJson = [
          {
            'id': 1,
            'name': 'Test Compound',
            'area_id': 1,
            'developer_id': 1,
            'slug': 'test-compound',
            'area': {'id': 1, 'name': 'Cairo'},
          },
        ];

        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: compoundsJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await remoteSource.getCompounds();

        // Assert
        expect(result, hasLength(1));
        expect(result.first.name, 'Test Compound');
        verify(() => mockDio.get('/compounds.json')).called(1);
      });
    });

    group('searchProperties', () {
      test('should return search response with properties', () async {
        // Arrange
        final searchResponseJson = {
          'total_properties': 100,
          'total_compounds': 5,
          'total_property_groups': 10,
          'values': [
            {
              'id': 1,
              'name': 'Test Property',
              'min_price': 1000000,
              'max_price': 2000000,
              'currency': 'EGP',
              'number_of_bedrooms': 2,
              'number_of_bathrooms': 2,
            },
          ],
        };

        when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            data: searchResponseJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await remoteSource.searchProperties(
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

        // Verify query parameters were passed correctly
        final captured =
            verify(
                  () => mockDio.get(
                    '/properties-search.json',
                    queryParameters: captureAny(named: 'queryParameters'),
                  ),
                ).captured.first
                as Map<String, dynamic>;

        expect(captured['area_ids'], '1,2');
        expect(captured['min_price'], 500000);
        expect(captured['max_price'], 2000000);
        expect(captured['min_bedrooms'], 2);
        expect(captured['max_bedrooms'], 4);
      });

      test('should handle empty search parameters', () async {
        // Arrange
        final searchResponseJson = {
          'total_properties': 50,
          'total_compounds': 0,
          'total_property_groups': 0,
          'values': [],
        };

        when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            data: searchResponseJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await remoteSource.searchProperties();

        // Assert
        expect(result.totalProperties, 50);
        expect(result.properties, isEmpty);

        // Verify empty query parameters
        final captured =
            verify(
                  () => mockDio.get(
                    '/properties-search.json',
                    queryParameters: captureAny(named: 'queryParameters'),
                  ),
                ).captured.first
                as Map<String, dynamic>;

        expect(captured, isEmpty);
      });

      test('should handle null and empty list parameters correctly', () async {
        // Arrange
        when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            data: {
              'total_properties': 0,
              'total_compounds': 0,
              'total_property_groups': 0,
              'values': [],
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        await remoteSource.searchProperties(
          areaIds: [], // Empty list
          compoundIds: null, // Null
          propertyTypeIds: [], // Empty list
        );

        // Assert
        final captured =
            verify(
                  () => mockDio.get(
                    '/properties-search.json',
                    queryParameters: captureAny(named: 'queryParameters'),
                  ),
                ).captured.first
                as Map<String, dynamic>;

        // Empty lists and null values should not be included in query params
        expect(captured.containsKey('area_ids'), false);
        expect(captured.containsKey('compound_ids'), false);
        expect(captured.containsKey('property_type_ids'), false);
      });
    });

    group('getFilterOptions', () {
      test('should return filter options on successful API call', () async {
        // Arrange
        final filterOptionsJson = {
          'min_bedrooms': 1,
          'max_bedrooms': 5,
          'min_price_list': [500000],
          'max_price_list': [10000000],
          'property_types': [
            {
              'id': 1,
              'name': 'Apartment',
              'icon': {'url': 'https://example.com/apartment.png'},
              'has_land_area': false,
              'has_mandatory_garden_area': false,
              'manual_ranking': 1,
            },
            {
              'id': 2,
              'name': 'Villa',
              'icon': {'url': 'https://example.com/villa.png'},
              'has_land_area': true,
              'has_mandatory_garden_area': true,
              'manual_ranking': 2,
            },
          ],
          'amenities': [],
          'sortings': [],
          'sale_types': [],
        };

        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: filterOptionsJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        // Act
        final result = await remoteSource.getFilterOptions();

        // Assert
        expect(result.minBedrooms, 1);
        expect(result.maxBedrooms, 5);
        expect(result.propertyTypes, hasLength(2));
        verify(() => mockDio.get('/properties-get-filter-options.json')).called(1);
      });
    });

    group('Error Handling', () {
      test('should handle connection timeout correctly', () async {
        // Arrange
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        // Act & Assert
        expect(
          () => remoteSource.getAreas(),
          throwsA(
            predicate((e) => e is AppException && e.message.contains('Something went wrong')),
          ),
        );
      });

      test('should handle server error correctly', () async {
        // Arrange
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.badResponse,
            response: Response(statusCode: 500, requestOptions: RequestOptions(path: '')),
          ),
        );

        // Act & Assert
        expect(
          () => remoteSource.getAreas(),
          throwsA(
            predicate((e) => e is AppException && e.message.contains('Something went wrong')),
          ),
        );
      });

      test('should handle network error correctly', () async {
        // Arrange
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        // Act & Assert
        expect(
          () => remoteSource.getAreas(),
          throwsA(
            predicate((e) => e is AppException && e.message.contains('Something went wrong')),
          ),
        );
      });
    });
  });
}
