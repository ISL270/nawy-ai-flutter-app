import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

/// API Monitoring Tests - Detect API changes and new fields
/// Run these tests regularly to catch API evolution early
void main() {
  group('API Monitoring Tests', () {
    const baseUrl = 'https://hiring-tasks.github.io/mobile-app-apis';

    test('Monitor Properties API for new fields', () async {
      // Arrange
      final knownFields = {
        'id', 'slug', 'name', 'property_type', 'compound', 'area', 'developer',
        'image', 'finishing', 'min_unit_area', 'max_unit_area', 'min_price',
        'max_price', 'currency', 'max_installment_years', 'max_installment_years_months',
        'min_installments', 'min_down_payment', 'number_of_bathrooms', 'number_of_bedrooms',
        'min_ready_by', 'sponsored', 'new_property', 'company', 'resale', 'financing',
        'type', 'has_offers', 'offer_title', 'limited_time_offer', 'is_cash',
        'installment_type', 'in_quick_search', 'recommended', 'manual_ranking',
        'completeness_score', 'favorite', 'ranking_type', 'recommended_financing',
        'property_ranking', 'compound_ranking', 'tags'
      };

      // Act
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');
      final data = response.data;
      final properties = data['values'] as List;

      if (properties.isNotEmpty) {
        final property = properties.first as Map<String, dynamic>;
        final actualFields = property.keys.toSet();
        
        // Check for new fields
        final newFields = actualFields.difference(knownFields);
        final missingFields = knownFields.difference(actualFields);

        // Assert
        if (newFields.isNotEmpty) {
          addTearDown(() => debugPrint('🆕 NEW FIELDS DETECTED: $newFields'));
          addTearDown(() => debugPrint('Consider adding these to PropertyDto model'));
        }
        
        if (missingFields.isNotEmpty) {
          addTearDown(() => debugPrint('⚠️ MISSING FIELDS: $missingFields'));
          addTearDown(() => debugPrint('These fields might have been removed from the API'));
        }

        // This test will pass but log warnings for manual review
        expect(response.statusCode, 200);
      }
    });

    test('Monitor API response structure changes', () async {
      // Arrange
      final expectedStructure = {
        'total_compounds': 'int',
        'total_properties': 'int', 
        'total_property_groups': 'int',
        'values': 'List',
        'property_types': 'List?',
      };

      // Act
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');
      final data = response.data;

      // Assert
      for (final entry in expectedStructure.entries) {
        final field = entry.key;
        final expectedType = entry.value;
        
        if (expectedType.endsWith('?')) {
          // Optional field
          final baseType = expectedType.substring(0, expectedType.length - 1);
          if (data.containsKey(field)) {
            expect(data[field].runtimeType.toString(), contains(baseType),
              reason: 'Field $field type changed from expected $expectedType');
          }
        } else {
          // Required field
          expect(data.containsKey(field), true, 
            reason: 'Required field $field is missing from API response');
          expect(data[field].runtimeType.toString(), contains(expectedType),
            reason: 'Field $field type changed from expected $expectedType');
        }
      }
    });

    test('Monitor API response sizes for performance', () async {
      // Act
      final endpoints = [
        {'name': 'Properties Search', 'url': '$baseUrl/properties-search.json', 'maxSize': 50000},
        {'name': 'Areas', 'url': '$baseUrl/areas.json', 'maxSize': 10000},
        {'name': 'Compounds', 'url': '$baseUrl/compounds.json', 'maxSize': 500000},
        {'name': 'Filter Options', 'url': '$baseUrl/properties-get-filter-options.json', 'maxSize': 20000},
      ];

      for (final endpoint in endpoints) {
        final dio = Dio();
        final response = await dio.get(endpoint['url'] as String);
        final size = json.encode(response.data).length;
        final maxSize = endpoint['maxSize'] as int;
        
        if (size > maxSize) {
          addTearDown(() => debugPrint('⚠️ ${endpoint['name']} response size ($size bytes) exceeds expected max ($maxSize bytes)'));
          addTearDown(() => debugPrint('Consider implementing pagination or optimizing the response'));
        }
        
        expect(response.statusCode, 200);
      }
    });

    test('Monitor critical property fields availability', () async {
      // Arrange - Fields critical for app functionality
      final criticalFields = {
        'id', 'name', 'min_price', 'max_price', 'currency',
        'number_of_bedrooms', 'number_of_bathrooms'
      };

      // Act
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');
      final data = response.data;
      final properties = data['values'] as List;

      // Assert
      if (properties.isNotEmpty) {
        final property = properties.first as Map<String, dynamic>;
        
        for (final field in criticalFields) {
          expect(property.containsKey(field), true,
            reason: 'Critical field $field is missing from API response');
          expect(property[field], isNotNull,
            reason: 'Critical field $field is null in API response');
        }
      }
    });

    test('Monitor nested object structures', () async {
      // Act
      final dio = Dio();
      final response = await dio.get('$baseUrl/properties-search.json');
      final data = response.data;
      final properties = data['values'] as List;

      if (properties.isNotEmpty) {
        final property = properties.first as Map<String, dynamic>;
        
        // Check compound structure
        if (property['compound'] != null) {
          final compound = property['compound'] as Map<String, dynamic>;
          final expectedCompoundFields = {'id', 'name'};
          
          for (final field in expectedCompoundFields) {
            expect(compound.containsKey(field), true,
              reason: 'Compound field $field is missing');
          }
        }
        
        // Check property_type structure
        if (property['property_type'] != null) {
          final propertyType = property['property_type'] as Map<String, dynamic>;
          final expectedTypeFields = {'id', 'name'};
          
          for (final field in expectedTypeFields) {
            expect(propertyType.containsKey(field), true,
              reason: 'Property type field $field is missing');
          }
        }
      }
    });
  });
}
