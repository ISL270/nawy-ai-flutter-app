import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_dto.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';

/// API Contract Tests - Validate that our models match the actual API responses
/// These tests will fail if the API structure changes, alerting us to model drift
void main() {
  group('API Contract Tests', () {
    const baseUrl = 'https://hiring-tasks.github.io/mobile-app-apis';

    test('Properties Search API contract validation', () async {
      // Arrange
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');

      // Assert API is accessible
      expect(response.statusCode, 200);

      final data = response.data;

      // Validate SearchResponse structure
      expect(data, isA<Map<String, dynamic>>());
      expect(data.containsKey('total_properties'), true);
      expect(data.containsKey('total_compounds'), true);
      expect(data.containsKey('values'), true);
      expect(data['values'], isA<List>());

      // Test SearchResponse deserialization
      expect(() => PropertySearchResponse.fromJson(data), returnsNormally);
      final searchResponse = PropertySearchResponse.fromJson(data);
      expect(searchResponse.properties, isNotEmpty);

      // Validate PropertyDto structure with actual API data
      final properties = data['values'] as List;
      if (properties.isNotEmpty) {
        final propertyJson = properties.first as Map<String, dynamic>;

        // Test PropertyDto deserialization
        expect(() => PropertyDto.fromJson(propertyJson), returnsNormally);
        final property = PropertyDto.fromJson(propertyJson);

        // Validate critical fields exist
        expect(property.id, isNotNull);
        expect(property.name, isNotNull);

        // Validate nested objects can be deserialized
        if (propertyJson['compound'] != null) {
          expect(() => PropertyCompoundDto.fromJson(propertyJson['compound']), returnsNormally);
        }
      }
    });

    test('Areas API contract validation', () async {
      // Arrange
      final dio = Dio();
      final response = await dio.get('$baseUrl/areas.json');

      // Assert
      expect(response.statusCode, 200);

      final data = response.data;
      expect(data, isA<List>());

      if ((data as List).isNotEmpty) {
        final areaJson = data.first as Map<String, dynamic>;

        // Test AreaDto deserialization
        expect(() => AreaDto.fromJson(areaJson), returnsNormally);
        final area = AreaDto.fromJson(areaJson);

        expect(area.id, isNotNull);
        expect(area.name, isNotNull);
      }
    });

    test('Compounds API contract validation', () async {
      // Arrange
      final dio = Dio();
      final response = await dio.get('$baseUrl/compounds.json');

      // Assert
      expect(response.statusCode, 200);

      final data = response.data;
      expect(data, isA<List>());

      if ((data as List).isNotEmpty) {
        final compoundJson = data.first as Map<String, dynamic>;

        // Test CompoundDto deserialization
        expect(() => CompoundDto.fromJson(compoundJson), returnsNormally);
        final compound = CompoundDto.fromJson(compoundJson);

        expect(compound.id, isNotNull);
        expect(compound.name, isNotNull);
      }
    });

    test('Filter Options API contract validation', () async {
      // Arrange
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-get-filter-options.json');

      // Assert
      expect(response.statusCode, 200);

      final data = response.data;
      expect(data, isA<Map<String, dynamic>>());

      // Test FilterOptions deserialization
      expect(() => FilterOptions.fromJson(data), returnsNormally);
      final filterOptions = FilterOptions.fromJson(data);

      expect(filterOptions.propertyTypes, isNotNull);
      expect(filterOptions.propertyTypes, isNotEmpty);
    });

    test('API field coverage validation', () async {
      // This test validates that we're not missing any fields from the API
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');
      final data = response.data;
      final properties = data['values'] as List;

      if (properties.isNotEmpty) {
        final propertyJson = properties.first as Map<String, dynamic>;
        final property = PropertyDto.fromJson(propertyJson);

        // Convert back to JSON to check if we lose any data
        final serializedJson = property.toJson();

        // Critical fields that must be preserved
        final criticalFields = [
          'id',
          'name',
          'slug',
          'property_type',
          'compound',
          'area',
          'developer',
          'image',
          'finishing',
          'min_unit_area',
          'max_unit_area',
          'min_price',
          'max_price',
          'currency',
          'number_of_bedrooms',
          'number_of_bathrooms',
        ];

        for (final field in criticalFields) {
          if (propertyJson.containsKey(field) && propertyJson[field] != null) {
            expect(
              serializedJson.containsKey(field),
              true,
              reason: 'Field $field is missing from serialized PropertyDto',
            );
          }
        }
      }
    });
  });
}
