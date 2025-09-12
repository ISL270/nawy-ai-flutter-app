import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/area_dto.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart';

/// AreaDto Unit Tests
/// Tests JSON serialization, deserialization, and domain entity conversion
void main() {
  group('AreaDto Tests', () {
    const sampleAreaJson = {
      'id': 123,
      'name': 'New Cairo',
      'slug': 'new-cairo',
      'all_slugs': {
        'en': 'new-cairo',
        'ar': 'القاهرة-الجديدة',
        'fr': 'nouveau-caire'
      }
    };

    const minimalAreaJson = {
      'id': 456,
      'name': 'Minimal Area',
    };

    group('JSON Deserialization', () {
      test('should deserialize complete area from JSON', () {
        // Act
        final area = AreaDto.fromJson(sampleAreaJson);

        // Assert
        expect(area.id, equals(123));
        expect(area.name, equals('New Cairo'));
        expect(area.slug, equals('new-cairo'));
        expect(area.allSlugs, isNotNull);
        expect(area.allSlugs!['en'], equals('new-cairo'));
        expect(area.allSlugs!['ar'], equals('القاهرة-الجديدة'));
        expect(area.allSlugs!['fr'], equals('nouveau-caire'));
      });

      test('should deserialize minimal area with required fields only', () {
        // Act
        final area = AreaDto.fromJson(minimalAreaJson);

        // Assert
        expect(area.id, equals(456));
        expect(area.name, equals('Minimal Area'));
        expect(area.slug, isNull);
        expect(area.allSlugs, isNull);
      });

      test('should handle null values gracefully', () {
        // Arrange
        final jsonWithNulls = {
          'id': 789,
          'name': 'Test Area',
          'slug': null,
          'all_slugs': null,
        };

        // Act
        final area = AreaDto.fromJson(jsonWithNulls);

        // Assert
        expect(area.id, equals(789));
        expect(area.name, equals('Test Area'));
        expect(area.slug, isNull);
        expect(area.allSlugs, isNull);
      });

      test('should handle empty translations map', () {
        // Arrange
        final jsonWithEmptyTranslations = {
          'id': 101,
          'name': 'Empty Translations Area',
          'slug': 'empty-translations',
          'all_slugs': <String, String>{},
        };

        // Act
        final area = AreaDto.fromJson(jsonWithEmptyTranslations);

        // Assert
        expect(area.id, equals(101));
        expect(area.name, equals('Empty Translations Area'));
        expect(area.slug, equals('empty-translations'));
        expect(area.allSlugs, isNotNull);
        expect(area.allSlugs!.isEmpty, isTrue);
      });
    });

    group('JSON Serialization', () {
      test('should serialize complete area to JSON', () {
        // Arrange
        final area = AreaDto(
          id: 123,
          name: 'New Cairo',
          slug: 'new-cairo',
          allSlugs: {
            'en': 'new-cairo',
            'ar': 'القاهرة-الجديدة',
            'fr': 'nouveau-caire'
          },
        );

        // Act
        final json = area.toJson();

        // Assert
        expect(json['id'], equals(123));
        expect(json['name'], equals('New Cairo'));
        expect(json['slug'], equals('new-cairo'));
        expect(json['all_slugs'], isNotNull);
        expect(json['all_slugs']['en'], equals('new-cairo'));
        expect(json['all_slugs']['ar'], equals('القاهرة-الجديدة'));
        expect(json['all_slugs']['fr'], equals('nouveau-caire'));
      });

      test('should serialize minimal area with null values', () {
        // Arrange
        final area = AreaDto(
          id: 456,
          name: 'Minimal Area',
        );

        // Act
        final json = area.toJson();

        // Assert
        expect(json['id'], equals(456));
        expect(json['name'], equals('Minimal Area'));
        expect(json['slug'], isNull);
        expect(json['all_slugs'], isNull);
      });
    });

    group('Round-trip Serialization', () {
      test('should maintain data integrity through round-trip conversion', () {
        // Arrange
        final originalArea = AreaDto.fromJson(sampleAreaJson);

        // Act
        final json = originalArea.toJson();
        final deserializedArea = AreaDto.fromJson(json);

        // Assert
        expect(deserializedArea.id, equals(originalArea.id));
        expect(deserializedArea.name, equals(originalArea.name));
        expect(deserializedArea.slug, equals(originalArea.slug));
        expect(deserializedArea.allSlugs, equals(originalArea.allSlugs));
      });

      test('should handle minimal area round-trip', () {
        // Arrange
        final originalArea = AreaDto.fromJson(minimalAreaJson);

        // Act
        final json = originalArea.toJson();
        final deserializedArea = AreaDto.fromJson(json);

        // Assert
        expect(deserializedArea.id, equals(originalArea.id));
        expect(deserializedArea.name, equals(originalArea.name));
        expect(deserializedArea.slug, equals(originalArea.slug));
        expect(deserializedArea.allSlugs, equals(originalArea.allSlugs));
      });
    });

    group('Domain Entity Conversion', () {
      test('should convert DTO to domain entity correctly', () {
        // Arrange
        final areaDto = AreaDto.fromJson(sampleAreaJson);

        // Act
        final domainEntity = areaDto.toEntity();

        // Assert
        expect(domainEntity.id, equals(123));
        expect(domainEntity.name, equals('New Cairo'));
        expect(domainEntity.slug, equals('new-cairo'));
        expect(domainEntity.translations, isNotNull);
        expect(domainEntity.translations!['en'], equals('new-cairo'));
        expect(domainEntity.translations!['ar'], equals('القاهرة-الجديدة'));
        expect(domainEntity.translations!['fr'], equals('nouveau-caire'));
      });

      test('should convert minimal DTO to domain entity', () {
        // Arrange
        final areaDto = AreaDto.fromJson(minimalAreaJson);

        // Act
        final domainEntity = areaDto.toEntity();

        // Assert
        expect(domainEntity.id, equals(456));
        expect(domainEntity.name, equals('Minimal Area'));
        expect(domainEntity.slug, isNull);
        expect(domainEntity.translations, isNull);
      });

      test('should convert domain entity to DTO correctly', () {
        // Arrange
        final domainEntity = Area(
          id: 123,
          name: 'New Cairo',
          slug: 'new-cairo',
          translations: {
            'en': 'new-cairo',
            'ar': 'القاهرة-الجديدة',
            'fr': 'nouveau-caire'
          },
        );

        // Act
        final dto = AreaDto.fromEntity(domainEntity);

        // Assert
        expect(dto.id, equals(123));
        expect(dto.name, equals('New Cairo'));
        expect(dto.slug, equals('new-cairo'));
        expect(dto.allSlugs, isNotNull);
        expect(dto.allSlugs!['en'], equals('new-cairo'));
        expect(dto.allSlugs!['ar'], equals('القاهرة-الجديدة'));
        expect(dto.allSlugs!['fr'], equals('nouveau-caire'));
      });

      test('should handle domain entity with null translations', () {
        // Arrange
        final domainEntity = Area(
          id: 456,
          name: 'Minimal Area',
          slug: null,
          translations: null,
        );

        // Act
        final dto = AreaDto.fromEntity(domainEntity);

        // Assert
        expect(dto.id, equals(456));
        expect(dto.name, equals('Minimal Area'));
        expect(dto.slug, isNull);
        expect(dto.allSlugs, isNull);
      });
    });

    group('Edge Cases', () {
      test('should handle malformed JSON gracefully', () {
        // Arrange
        final malformedJson = {
          'id': 'not-a-number', // Should be int
          'name': 'Test Area',
        };

        // Act & Assert
        expect(() => AreaDto.fromJson(malformedJson), throwsA(isA<TypeError>()));
      });

      test('should handle missing required fields', () {
        // Arrange
        final incompleteJson = {
          'id': 123,
          // Missing name
        };

        // Act & Assert
        expect(() => AreaDto.fromJson(incompleteJson), throwsA(isA<TypeError>()));
      });

      test('should handle invalid translations format', () {
        // Arrange
        final jsonWithInvalidTranslations = {
          'id': 123,
          'name': 'Test Area',
          'all_slugs': 'not-a-map', // Should be Map<String, String>
        };

        // Act & Assert
        expect(() => AreaDto.fromJson(jsonWithInvalidTranslations), throwsA(isA<TypeError>()));
      });
    });

    group('Translations Handling', () {
      test('should preserve all translation languages', () {
        // Arrange
        final multiLanguageJson = {
          'id': 123,
          'name': 'Test Area',
          'slug': 'test-area',
          'all_slugs': {
            'en': 'test-area',
            'ar': 'منطقة-تجريبية',
            'fr': 'zone-test',
            'de': 'test-bereich',
            'es': 'area-prueba',
          }
        };

        // Act
        final area = AreaDto.fromJson(multiLanguageJson);
        final entity = area.toEntity();

        // Assert
        expect(area.allSlugs!.length, equals(5));
        expect(entity.translations!.length, equals(5));
        expect(entity.translations!['en'], equals('test-area'));
        expect(entity.translations!['ar'], equals('منطقة-تجريبية'));
        expect(entity.translations!['fr'], equals('zone-test'));
        expect(entity.translations!['de'], equals('test-bereich'));
        expect(entity.translations!['es'], equals('area-prueba'));
      });

      test('should handle single language translation', () {
        // Arrange
        final singleLanguageJson = {
          'id': 123,
          'name': 'Test Area',
          'all_slugs': {
            'en': 'test-area',
          }
        };

        // Act
        final area = AreaDto.fromJson(singleLanguageJson);
        final entity = area.toEntity();

        // Assert
        expect(area.allSlugs!.length, equals(1));
        expect(entity.translations!.length, equals(1));
        expect(entity.translations!['en'], equals('test-area'));
      });
    });

    group('Field Validation', () {
      test('should validate required id field', () {
        // Arrange
        final jsonWithoutId = {
          'name': 'Test Area',
        };

        // Act & Assert
        expect(() => AreaDto.fromJson(jsonWithoutId), throwsA(isA<TypeError>()));
      });

      test('should validate required name field', () {
        // Arrange
        final jsonWithoutName = {
          'id': 123,
        };

        // Act & Assert
        expect(() => AreaDto.fromJson(jsonWithoutName), throwsA(isA<TypeError>()));
      });

      test('should accept zero as valid id', () {
        // Arrange
        final jsonWithZeroId = {
          'id': 0,
          'name': 'Zero ID Area',
        };

        // Act
        final area = AreaDto.fromJson(jsonWithZeroId);

        // Assert
        expect(area.id, equals(0));
        expect(area.name, equals('Zero ID Area'));
      });

      test('should accept empty string as valid name', () {
        // Arrange
        final jsonWithEmptyName = {
          'id': 123,
          'name': '',
        };

        // Act
        final area = AreaDto.fromJson(jsonWithEmptyName);

        // Assert
        expect(area.id, equals(123));
        expect(area.name, equals(''));
      });
    });
  });
}
