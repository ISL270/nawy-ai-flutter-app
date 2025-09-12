import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/compound_dto.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart';

/// CompoundDto Unit Tests
/// Tests JSON serialization, deserialization, and domain entity conversion
void main() {
  group('CompoundDto Tests', () {
    const sampleCompoundJson = {
      'id': 123,
      'area_id': 456,
      'developer_id': 789,
      'name': 'Test Compound',
      'slug': 'test-compound',
      'updated_at': '2024-01-15T10:30:00Z',
      'image_path': '/images/compound.jpg',
      'nawy_organization_id': 101,
      'has_offers': true,
      'area': {
        'id': 456,
        'name': 'Test Area',
        'slug': 'test-area',
        'all_slugs': {'en': 'test-area', 'ar': 'منطقة-تجريبية'}
      }
    };

    const minimalCompoundJson = {
      'id': 123,
      'area_id': 456,
      'name': 'Minimal Compound',
    };

    group('JSON Deserialization', () {
      test('should deserialize complete compound from JSON', () {
        // Act
        final compound = CompoundDto.fromJson(sampleCompoundJson);

        // Assert
        expect(compound.id, equals(123));
        expect(compound.areaId, equals(456));
        expect(compound.developerId, equals(789));
        expect(compound.name, equals('Test Compound'));
        expect(compound.slug, equals('test-compound'));
        expect(compound.updatedAt, equals('2024-01-15T10:30:00Z'));
        expect(compound.imagePath, equals('/images/compound.jpg'));
        expect(compound.nawyOrganizationId, equals(101));
        expect(compound.hasOffers, equals(true));
        expect(compound.area, isNotNull);
        expect(compound.area!.id, equals(456));
        expect(compound.area!.name, equals('Test Area'));
      });

      test('should deserialize minimal compound with required fields only', () {
        // Act
        final compound = CompoundDto.fromJson(minimalCompoundJson);

        // Assert
        expect(compound.id, equals(123));
        expect(compound.areaId, equals(456));
        expect(compound.name, equals('Minimal Compound'));
        expect(compound.developerId, isNull);
        expect(compound.slug, isNull);
        expect(compound.updatedAt, isNull);
        expect(compound.imagePath, isNull);
        expect(compound.nawyOrganizationId, isNull);
        expect(compound.hasOffers, isNull);
        expect(compound.area, isNull);
      });

      test('should handle null values gracefully', () {
        // Arrange
        final jsonWithNulls = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'developer_id': null,
          'slug': null,
          'updated_at': null,
          'image_path': null,
          'nawy_organization_id': null,
          'has_offers': null,
          'area': null,
        };

        // Act
        final compound = CompoundDto.fromJson(jsonWithNulls);

        // Assert
        expect(compound.id, equals(123));
        expect(compound.areaId, equals(456));
        expect(compound.name, equals('Test Compound'));
        expect(compound.developerId, isNull);
        expect(compound.slug, isNull);
        expect(compound.updatedAt, isNull);
        expect(compound.imagePath, isNull);
        expect(compound.nawyOrganizationId, isNull);
        expect(compound.hasOffers, isNull);
        expect(compound.area, isNull);
      });
    });

    group('JSON Serialization', () {
      test('should serialize complete compound to JSON', () {
        // Arrange
        final areaDto = AreaDto(
          id: 456,
          name: 'Test Area',
          slug: 'test-area',
          allSlugs: {'en': 'test-area', 'ar': 'منطقة-تجريبية'},
        );

        final compound = CompoundDto(
          id: 123,
          areaId: 456,
          developerId: 789,
          name: 'Test Compound',
          slug: 'test-compound',
          updatedAt: '2024-01-15T10:30:00Z',
          imagePath: '/images/compound.jpg',
          nawyOrganizationId: 101,
          hasOffers: true,
          area: areaDto,
        );

        // Act
        final json = compound.toJson();

        // Assert
        expect(json['id'], equals(123));
        expect(json['area_id'], equals(456));
        expect(json['developer_id'], equals(789));
        expect(json['name'], equals('Test Compound'));
        expect(json['slug'], equals('test-compound'));
        expect(json['updated_at'], equals('2024-01-15T10:30:00Z'));
        expect(json['image_path'], equals('/images/compound.jpg'));
        expect(json['nawy_organization_id'], equals(101));
        expect(json['has_offers'], equals(true));
        expect(json['area'], isNotNull);
        // Note: area is serialized as AreaDto object, not JSON map in this context
      });

      test('should serialize minimal compound with null values', () {
        // Arrange
        final compound = CompoundDto(
          id: 123,
          areaId: 456,
          name: 'Minimal Compound',
        );

        // Act
        final json = compound.toJson();

        // Assert
        expect(json['id'], equals(123));
        expect(json['area_id'], equals(456));
        expect(json['name'], equals('Minimal Compound'));
        expect(json['developer_id'], isNull);
        expect(json['slug'], isNull);
        expect(json['updated_at'], isNull);
        expect(json['image_path'], isNull);
        expect(json['nawy_organization_id'], isNull);
        expect(json['has_offers'], isNull);
        expect(json['area'], isNull);
      });
    });

    group('JSON Serialization Validation', () {
      test('should serialize basic fields correctly', () {
        // Arrange
        final compound = CompoundDto.fromJson(sampleCompoundJson);

        // Act
        final json = compound.toJson();

        // Assert - Basic fields should be serialized correctly
        expect(json['id'], equals(compound.id));
        expect(json['area_id'], equals(compound.areaId));
        expect(json['developer_id'], equals(compound.developerId));
        expect(json['name'], equals(compound.name));
        expect(json['slug'], equals(compound.slug));
        expect(json['updated_at'], equals(compound.updatedAt));
        expect(json['image_path'], equals(compound.imagePath));
        expect(json['nawy_organization_id'], equals(compound.nawyOrganizationId));
        expect(json['has_offers'], equals(compound.hasOffers));
      });

      test('should handle nested area object in serialization', () {
        // Arrange
        final compound = CompoundDto.fromJson(sampleCompoundJson);

        // Act
        final json = compound.toJson();

        // Assert - Nested area should be present
        expect(json['area'], isNotNull);
      });
    });

    group('Domain Entity Conversion', () {
      test('should convert DTO to domain entity correctly', () {
        // Arrange
        final compoundDto = CompoundDto.fromJson(sampleCompoundJson);

        // Act
        final domainEntity = compoundDto.toEntity();

        // Assert
        expect(domainEntity.id, equals(123));
        expect(domainEntity.areaId, equals(456));
        expect(domainEntity.developerId, equals(789));
        expect(domainEntity.name, equals('Test Compound'));
        expect(domainEntity.slug, equals('test-compound'));
        expect(domainEntity.imagePath, equals('/images/compound.jpg'));
        expect(domainEntity.nawyOrganizationId, equals(101));
        expect(domainEntity.hasOffers, equals(true));
        expect(domainEntity.isFavorite, equals(false)); // Default value
        expect(domainEntity.area, isNotNull);
        expect(domainEntity.area!.id, equals(456));
        expect(domainEntity.area!.name, equals('Test Area'));
        expect(domainEntity.updatedAt, isNotNull);
        expect(domainEntity.updatedAt!.year, equals(2024));
        expect(domainEntity.updatedAt!.month, equals(1));
        expect(domainEntity.updatedAt!.day, equals(15));
      });

      test('should handle null hasOffers with default false value', () {
        // Arrange
        final compoundDto = CompoundDto.fromJson(minimalCompoundJson);

        // Act
        final domainEntity = compoundDto.toEntity();

        // Assert
        expect(domainEntity.hasOffers, equals(false));
        expect(domainEntity.isFavorite, equals(false));
      });

      test('should handle invalid date parsing gracefully', () {
        // Arrange
        final jsonWithInvalidDate = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'updated_at': 'invalid-date-format',
        };
        final compoundDto = CompoundDto.fromJson(jsonWithInvalidDate);

        // Act
        final domainEntity = compoundDto.toEntity();

        // Assert
        expect(domainEntity.updatedAt, isNull);
      });

      test('should convert domain entity to DTO correctly', () {
        // Arrange
        final area = Area(
          id: 456,
          name: 'Test Area',
          slug: 'test-area',
          translations: {'en': 'test-area', 'ar': 'منطقة-تجريبية'},
        );

        final domainEntity = Compound(
          id: 123,
          areaId: 456,
          name: 'Test Compound',
          slug: 'test-compound',
          imagePath: '/images/compound.jpg',
          developerId: 789,
          updatedAt: DateTime.parse('2024-01-15T10:30:00Z'),
          nawyOrganizationId: 101,
          hasOffers: true,
          area: area,
          isFavorite: true, // This won't be serialized to API
        );

        // Act
        final dto = CompoundDto.fromEntity(domainEntity);

        // Assert
        expect(dto.id, equals(123));
        expect(dto.areaId, equals(456));
        expect(dto.developerId, equals(789));
        expect(dto.name, equals('Test Compound'));
        expect(dto.slug, equals('test-compound'));
        expect(dto.imagePath, equals('/images/compound.jpg'));
        expect(dto.nawyOrganizationId, equals(101));
        expect(dto.hasOffers, equals(true));
        expect(dto.updatedAt, equals('2024-01-15T10:30:00.000Z'));
        expect(dto.area, isNotNull);
        expect(dto.area!.id, equals(456));
        expect(dto.area!.name, equals('Test Area'));
      });
    });

    group('Edge Cases', () {
      test('should handle empty area object', () {
        // Arrange
        final jsonWithEmptyArea = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'area': <String, dynamic>{},
        };

        // Act & Assert
        expect(() => CompoundDto.fromJson(jsonWithEmptyArea), throwsA(isA<TypeError>()));
      });

      test('should handle malformed JSON gracefully', () {
        // Arrange
        final malformedJson = {
          'id': 'not-a-number', // Should be int
          'area_id': 456,
          'name': 'Test Compound',
        };

        // Act & Assert
        expect(() => CompoundDto.fromJson(malformedJson), throwsA(isA<TypeError>()));
      });

      test('should handle missing required fields', () {
        // Arrange
        final incompleteJson = {
          'id': 123,
          // Missing area_id and name
        };

        // Act & Assert
        expect(() => CompoundDto.fromJson(incompleteJson), throwsA(isA<TypeError>()));
      });
    });

    group('Boolean Field Handling', () {
      test('should handle hasOffers as true', () {
        // Arrange
        final json = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'has_offers': true,
        };

        // Act
        final compound = CompoundDto.fromJson(json);
        final entity = compound.toEntity();

        // Assert
        expect(compound.hasOffers, equals(true));
        expect(entity.hasOffers, equals(true));
      });

      test('should handle hasOffers as false', () {
        // Arrange
        final json = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'has_offers': false,
        };

        // Act
        final compound = CompoundDto.fromJson(json);
        final entity = compound.toEntity();

        // Assert
        expect(compound.hasOffers, equals(false));
        expect(entity.hasOffers, equals(false));
      });

      test('should default hasOffers to false when null', () {
        // Arrange
        final json = {
          'id': 123,
          'area_id': 456,
          'name': 'Test Compound',
          'has_offers': null,
        };

        // Act
        final compound = CompoundDto.fromJson(json);
        final entity = compound.toEntity();

        // Assert
        expect(compound.hasOffers, isNull);
        expect(entity.hasOffers, equals(false));
      });
    });
  });
}
