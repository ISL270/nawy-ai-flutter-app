import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_dto.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/property.dart';

/// PropertyDto Serialization/Deserialization Tests
/// Ensures JSON mapping works correctly and catches breaking changes
void main() {
  group('PropertyDto Tests', () {
    late Map<String, dynamic> validPropertyJson;
    late PropertyDto validPropertyDto;

    setUp(() {
      // Sample JSON that matches the actual API structure
      validPropertyJson = {
        'id': 46370,
        'slug': '46370-apartment-for-sale-in-zed-with-2-bedrooms',
        'name': 'Apartment for sale in ZED with 2 bedrooms',
        'property_type': {
          'id': 21, 
          'name': 'Apartment', 
          'manual_ranking': 1,
          'icon': {'url': 'https://example.com/apartment-icon.png'},
          'has_land_area': false,
          'has_mandatory_garden_area': false
        },
        'compound': {
          'id': 274,
          'lat': 30.0466084,
          'long': 31.00310115,
          'name': 'ZED',
          'slug': '274-zed-el-sheikh-zayed-ora',
          'sponsored': 0,
          'nawy_organization_id': null,
        },
        'area': {'id': 26, 'name': 'El Sheikh Zayed'},
        'developer': {
          'id': 85,
          'name': 'Ora Developers',
          'slug': '85-ora-developers',
          'logo_path': 'https://example.com/logo.jpg',
        },
        'image': 'https://example.com/property.jpg',
        'finishing': 'finished',
        'min_unit_area': 144,
        'max_unit_area': 144,
        'min_price': 14552000,
        'max_price': 16040000,
        'currency': 'EGP',
        'max_installment_years': 8,
        'max_installment_years_months': '8.0',
        'min_installments': 136425,
        'min_down_payment': 727600,
        'number_of_bathrooms': 3,
        'number_of_bedrooms': 2,
        'min_ready_by': '2024-10-31',
        'sponsored': 0,
        'new_property': false,
        'resale': false,
        'financing': false,
        'has_offers': false,
        'offer_title': '',
        'limited_time_offer': false,
        'favorite': false,
        'ranking_type': 'fast_moving',
        'recommended_financing': 14527,
        'property_ranking': 9.0,
        'compound_ranking': 15,
        'tags': [],
      };

      validPropertyDto = PropertyDto(
        id: 46370,
        name: 'Apartment for sale in ZED with 2 bedrooms',
        slug: '46370-apartment-for-sale-in-zed-with-2-bedrooms',
        minUnitArea: 144.0,
        maxUnitArea: 144.0,
        minPrice: 14552000.0,
        maxPrice: 16040000.0,
        currency: 'EGP',
        numberOfBedrooms: 2,
        numberOfBathrooms: 3,
        finishing: 'finished',
        newProperty: false,
        resale: false,
        financing: false,
        hasOffers: false,
        limitedTimeOffer: false,
        favorite: false,
      );
    });

    group('JSON Deserialization', () {
      test('should deserialize valid JSON correctly', () {
        // Act
        final result = PropertyDto.fromJson(validPropertyJson);

        // Assert
        expect(result.id, 46370);
        expect(result.name, 'Apartment for sale in ZED with 2 bedrooms');
        expect(result.numberOfBedrooms, 2);
        expect(result.numberOfBathrooms, 3);
        expect(result.minPrice, 14552000);
        expect(result.maxPrice, 16040000);
        expect(result.currency, 'EGP');
        expect(result.newProperty, false);
        expect(result.favorite, false);
      });

      test('should handle missing optional fields gracefully', () {
        // Arrange
        final minimalJson = {'id': 123, 'name': 'Test Property'};

        // Act
        final result = PropertyDto.fromJson(minimalJson);

        // Assert
        expect(result.id, 123);
        expect(result.name, 'Test Property');
        expect(result.slug, isNull);
        expect(result.numberOfBedrooms, isNull);
        expect(result.newProperty, isNull);
      });

      test('should handle null values in optional fields', () {
        // Arrange
        final jsonWithNulls = {
          'id': 123,
          'name': 'Test Property',
          'slug': null,
          'number_of_bedrooms': null,
          'compound': null,
        };

        // Act
        final result = PropertyDto.fromJson(jsonWithNulls);

        // Assert
        expect(result.id, 123);
        expect(result.name, 'Test Property');
        expect(result.slug, isNull);
        expect(result.numberOfBedrooms, isNull);
        expect(result.compound, isNull);
      });

      test('should deserialize nested compound object', () {
        // Act
        final result = PropertyDto.fromJson(validPropertyJson);

        // Assert
        expect(result.compound, isNotNull);
        expect(result.compound!.id, 274);
        expect(result.compound!.name, 'ZED');
        expect(result.compound!.lat, 30.0466084);
        expect(result.compound!.long, 31.00310115);
      });
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        // Act
        final result = validPropertyDto.toJson();

        // Assert
        expect(result['id'], 46370);
        expect(result['name'], 'Apartment for sale in ZED with 2 bedrooms');
        expect(result['number_of_bedrooms'], 2);
        expect(result['number_of_bathrooms'], 3);
        expect(result['min_price'], 14552000.0);
        expect(result['new_property'], false);
        expect(result['favorite'], false);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final dtoWithNulls = PropertyDto(
          id: 123,
          name: 'Test Property',
          slug: null,
          numberOfBedrooms: null,
        );

        // Act
        final result = dtoWithNulls.toJson();

        // Assert
        expect(result['id'], 123);
        expect(result['name'], 'Test Property');
        expect(result['slug'], isNull);
        expect(result['number_of_bedrooms'], isNull);
      });
    });

    group('JSON Serialization Validation', () {
      test('should serialize and deserialize basic fields correctly', () {
        // Act
        final dto = PropertyDto.fromJson(validPropertyJson);
        final serializedJson = dto.toJson();

        // Assert - Basic fields should be serialized correctly
        expect(serializedJson['id'], dto.id);
        expect(serializedJson['name'], dto.name);
        expect(serializedJson['slug'], dto.slug);
        expect(serializedJson['min_price'], dto.minPrice);
        expect(serializedJson['max_price'], dto.maxPrice);
        expect(serializedJson['number_of_bedrooms'], dto.numberOfBedrooms);
        expect(serializedJson['number_of_bathrooms'], dto.numberOfBathrooms);
        expect(serializedJson['currency'], dto.currency);
        expect(serializedJson['finishing'], dto.finishing);
      });

      test('should handle nested objects in serialization', () {
        // Act
        final dto = PropertyDto.fromJson(validPropertyJson);
        final serializedJson = dto.toJson();

        // Assert - Nested objects should be present
        expect(serializedJson['property_type'], isNotNull);
        expect(serializedJson['compound'], isNotNull);
        expect(serializedJson['area'], isNotNull);
        expect(serializedJson['developer'], isNotNull);
      });
    });

    group('Domain Entity Conversion', () {
      test('should convert to domain entity correctly', () {
        // Arrange
        final dto = PropertyDto.fromJson(validPropertyJson);

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity, isA<Property>());
        expect(entity.id, dto.id);
        expect(entity.name, dto.name);
        expect(entity.numberOfBedrooms, dto.numberOfBedrooms);
        expect(entity.numberOfBathrooms, dto.numberOfBathrooms);
        expect(entity.minPrice, dto.minPrice);
        expect(entity.newProperty, dto.newProperty ?? false);
        expect(entity.isFavorite, dto.favorite ?? false);
      });

      test('should convert from domain entity correctly', () {
        // Arrange
        final entity = Property(
          id: 123,
          name: 'Test Property',
          numberOfBedrooms: 3,
          numberOfBathrooms: 2,
          newProperty: true,
          isFavorite: true,
        );

        // Act
        final dto = PropertyDto.fromEntity(entity);

        // Assert
        expect(dto.id, entity.id);
        expect(dto.name, entity.name);
        expect(dto.numberOfBedrooms, entity.numberOfBedrooms);
        expect(dto.numberOfBathrooms, entity.numberOfBathrooms);
        expect(dto.newProperty, entity.newProperty);
        expect(dto.favorite, entity.isFavorite);
      });
    });

    group('Field Validation', () {
      test('should validate all new fields are accessible', () {
        // Arrange
        final dto = PropertyDto.fromJson(validPropertyJson);

        // Act & Assert - Test all new fields we added
        expect(() => dto.minInstallments, returnsNormally);
        expect(() => dto.minDownPayment, returnsNormally);
        expect(() => dto.numberOfBathrooms, returnsNormally);
        expect(() => dto.numberOfBedrooms, returnsNormally);
        expect(() => dto.minReadyBy, returnsNormally);
        expect(() => dto.sponsored, returnsNormally);
        expect(() => dto.newProperty, returnsNormally);
        expect(() => dto.resale, returnsNormally);
        expect(() => dto.financing, returnsNormally);
        expect(() => dto.hasOffers, returnsNormally);
        expect(() => dto.offerTitle, returnsNormally);
        expect(() => dto.limitedTimeOffer, returnsNormally);
        expect(() => dto.favorite, returnsNormally);
        expect(() => dto.rankingType, returnsNormally);
        expect(() => dto.recommendedFinancing, returnsNormally);
        expect(() => dto.propertyRanking, returnsNormally);
        expect(() => dto.compoundRanking, returnsNormally);
        expect(() => dto.tags, returnsNormally);
      });

      test('should handle boolean field defaults correctly', () {
        // Arrange
        final jsonWithoutBooleans = {'id': 123, 'name': 'Test Property'};

        // Act
        final dto = PropertyDto.fromJson(jsonWithoutBooleans);
        final entity = dto.toEntity();

        // Assert - Boolean fields should have proper defaults
        expect(entity.newProperty, false);
        expect(entity.resale, false);
        expect(entity.financing, false);
        expect(entity.hasOffers, false);
        expect(entity.limitedTimeOffer, false);
        expect(entity.isFavorite, false);
      });
    });
  });
}
