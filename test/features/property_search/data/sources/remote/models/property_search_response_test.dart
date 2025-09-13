import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';

/// PropertySearchResponse Model Tests
/// Validates the search response structure and pagination metadata
void main() {
  group('PropertySearchResponse Tests', () {
    late Map<String, dynamic> validPropertySearchResponseJson;

    setUp(() {
      validPropertySearchResponseJson = {
        'total_compounds': 0,
        'total_properties': 3770,
        'total_property_groups': 0,
        'property_types': [
          {'id': 21, 'count': 1444},
          {'id': 1, 'count': 472},
        ],
        'values': [
          {
            'id': 46370,
            'name': 'Test Property',
            'slug': 'test-property',
            'property_type': {'id': 21, 'name': 'Apartment'},
            'compound': {'id': 274, 'name': 'Test Compound', 'lat': 30.0, 'long': 31.0},
            'area': {'id': 26, 'name': 'Test Area'},
            'developer': {'id': 85, 'name': 'Test Developer'},
            'min_price': 1000000,
            'max_price': 2000000,
            'currency': 'EGP',
            'number_of_bedrooms': 2,
            'number_of_bathrooms': 2,
          },
        ],
      };
    });

    group('JSON Deserialization', () {
      test('should deserialize valid search response JSON', () {
        // Act
        final result = PropertySearchResponse.fromJson(validPropertySearchResponseJson);

        // Assert
        expect(result.totalCompounds, 0);
        expect(result.totalProperties, 3770);
        expect(result.totalPropertyGroups, 0);
        expect(result.properties, hasLength(1));
        expect(result.propertyTypes, hasLength(2));
      });

      test('should handle empty properties list', () {
        // Arrange
        final emptyJson = {
          'total_compounds': 0,
          'total_properties': 0,
          'total_property_groups': 0,
          'values': [],
        };

        // Act
        final result = PropertySearchResponse.fromJson(emptyJson);

        // Assert
        expect(result.totalProperties, 0);
        expect(result.properties, isEmpty);
      });

      test('should handle missing property_types field', () {
        // Arrange
        final jsonWithoutPropertyTypes = {
          'total_compounds': 0,
          'total_properties': 100,
          'total_property_groups': 0,
          'values': [],
        };

        // Act
        final result = PropertySearchResponse.fromJson(jsonWithoutPropertyTypes);

        // Assert
        expect(result.totalProperties, 100);
        expect(result.propertyTypes, isNull);
      });
    });

    group('Property Type Count Tests', () {
      test('should deserialize property type counts correctly', () {
        // Act
        final result = PropertySearchResponse.fromJson(validPropertySearchResponseJson);

        // Assert
        expect(result.propertyTypes, isNotNull);
        expect(result.propertyTypes!.first.id, 21);
        expect(result.propertyTypes!.first.count, 1444);
        expect(result.propertyTypes![1].id, 1);
        expect(result.propertyTypes![1].count, 472);
      });
    });

    group('Properties Validation', () {
      test('should deserialize properties correctly', () {
        // Act
        final result = PropertySearchResponse.fromJson(validPropertySearchResponseJson);

        // Assert
        final property = result.properties.first;
        expect(property.id, 46370);
        expect(property.name, 'Test Property');
        expect(property.numberOfBedrooms, 2);
        expect(property.numberOfBathrooms, 2);
      });

      test('should handle properties with all fields', () {
        // Arrange
        final fullPropertyJson = Map<String, dynamic>.from(validPropertySearchResponseJson);
        (fullPropertyJson['values'] as List)[0] = {
          'id': 12345,
          'name': 'Full Property',
          'slug': 'full-property',
          'min_price': 500000,
          'max_price': 1000000,
          'currency': 'EGP',
          'number_of_bedrooms': 3,
          'number_of_bathrooms': 2,
          'min_unit_area': 120,
          'max_unit_area': 150,
          'finishing': 'finished',
          'new_property': true,
          'resale': false,
          'financing': true,
          'has_offers': true,
          'offer_title': 'Special Offer',
          'limited_time_offer': true,
          'favorite': false,
          'sponsored': 1,
          'min_installments': 5000,
          'min_down_payment': 100000,
          'min_ready_by': '2025-12-31',
          'ranking_type': 'premium',
          'recommended_financing': 15000,
          'property_ranking': 8.5,
          'compound_ranking': 12,
          'tags': ['luxury', 'new'],
        };

        // Act
        final result = PropertySearchResponse.fromJson(fullPropertyJson);

        // Assert
        final property = result.properties.first;
        expect(property.id, 12345);
        expect(property.name, 'Full Property');
        expect(property.newProperty, true);
        expect(property.financing, true);
        expect(property.hasOffers, true);
        expect(property.offerTitle, 'Special Offer');
        expect(property.limitedTimeOffer, true);
        expect(property.sponsored, 1);
        expect(property.minInstallments, 5000);
        expect(property.rankingType, 'premium');
        expect(property.propertyRanking, 8.5);
        expect(property.tags, ['luxury', 'new']);
      });
    });

    group('JSON Serialization', () {
      test('should serialize back to JSON correctly', () {
        // Arrange
        final searchResponse = PropertySearchResponse.fromJson(validPropertySearchResponseJson);

        // Act
        final result = searchResponse.toJson();

        // Assert
        expect(result['total_compounds'], 0);
        expect(result['total_properties'], 3770);
        expect(result['total_property_groups'], 0);
        expect(result['values'], isA<List>());
        expect(result['property_types'], isA<List>());
      });
    });

    group('Pagination Metadata', () {
      test('should preserve pagination information', () {
        // Act
        final result = PropertySearchResponse.fromJson(validPropertySearchResponseJson);

        // Assert - These fields indicate total dataset size
        expect(result.totalProperties, 3770);
        expect(result.totalCompounds, 0);
        expect(result.totalPropertyGroups, 0);

        // Current page shows limited results
        expect(result.properties.length, lessThan(result.totalProperties));
      });

      test('should handle large totals correctly', () {
        // Arrange
        final largeDataJson = {
          'total_compounds': 1000,
          'total_properties': 50000,
          'total_property_groups': 500,
          'values': [],
        };

        // Act
        final result = PropertySearchResponse.fromJson(largeDataJson);

        // Assert
        expect(result.totalCompounds, 1000);
        expect(result.totalProperties, 50000);
        expect(result.totalPropertyGroups, 500);
      });
    });
  });
}
