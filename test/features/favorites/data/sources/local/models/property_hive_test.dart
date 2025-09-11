import 'package:flutter_test/flutter_test.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_hive.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';

void main() {
  group('PropertyHive', () {
    group('toEntity', () {
      test('should convert PropertyHive to Property domain entity correctly', () {
        final propertyHive = PropertyHive()
          ..propertyId = 1
          ..name = 'Test Property'
          ..slug = 'test-property'
          ..image = 'test-image.jpg'
          ..finishing = 'Finished'
          ..minUnitArea = 100.0
          ..maxUnitArea = 200.0
          ..minPrice = 1000000.0
          ..maxPrice = 2000000.0
          ..currency = 'EGP'
          ..maxInstallmentYears = 10
          ..maxInstallmentYearsMonths = '10 years'
          ..isFavorite = true;

        final entity = propertyHive.toEntity();

        expect(entity.id, 1);
        expect(entity.name, 'Test Property');
        expect(entity.slug, 'test-property');
        expect(entity.image, 'test-image.jpg');
        expect(entity.finishing, 'Finished');
        expect(entity.minUnitArea, 100.0);
        expect(entity.maxUnitArea, 200.0);
        expect(entity.minPrice, 1000000.0);
        expect(entity.maxPrice, 2000000.0);
        expect(entity.currency, 'EGP');
        expect(entity.maxInstallmentYears, 10);
        expect(entity.maxInstallmentYearsMonths, '10 years');
        expect(entity.isFavorite, true);
        // Related entities are null in toEntity (handled separately)
        expect(entity.propertyType, isNull);
        expect(entity.area, isNull);
        expect(entity.developer, isNull);
        expect(entity.compound, isNull);
      });

      test('should handle null values correctly', () {
        final propertyHive = PropertyHive()
          ..propertyId = 1
          ..name = 'Minimal Property'
          ..isFavorite = false;

        final entity = propertyHive.toEntity();

        expect(entity.id, 1);
        expect(entity.name, 'Minimal Property');
        expect(entity.slug, isNull);
        expect(entity.image, isNull);
        expect(entity.finishing, isNull);
        expect(entity.minUnitArea, isNull);
        expect(entity.maxUnitArea, isNull);
        expect(entity.minPrice, isNull);
        expect(entity.maxPrice, isNull);
        expect(entity.currency, isNull);
        expect(entity.maxInstallmentYears, isNull);
        expect(entity.maxInstallmentYearsMonths, isNull);
        expect(entity.isFavorite, false);
      });
    });

    group('fromEntity', () {
      test('should create PropertyHive from Property domain entity correctly', () {
        final entity = Property(
          id: 1,
          name: 'Test Property',
          slug: 'test-property',
          image: 'test-image.jpg',
          finishing: 'Finished',
          minUnitArea: 100.0,
          maxUnitArea: 200.0,
          minPrice: 1000000.0,
          maxPrice: 2000000.0,
          currency: 'EGP',
          maxInstallmentYears: 10,
          maxInstallmentYearsMonths: '10 years',
          isFavorite: true,
        );

        final propertyHive = PropertyHive.fromEntity(entity);

        expect(propertyHive.propertyId, 1);
        expect(propertyHive.name, 'Test Property');
        expect(propertyHive.slug, 'test-property');
        expect(propertyHive.image, 'test-image.jpg');
        expect(propertyHive.finishing, 'Finished');
        expect(propertyHive.minUnitArea, 100.0);
        expect(propertyHive.maxUnitArea, 200.0);
        expect(propertyHive.minPrice, 1000000.0);
        expect(propertyHive.maxPrice, 2000000.0);
        expect(propertyHive.currency, 'EGP');
        expect(propertyHive.maxInstallmentYears, 10);
        expect(propertyHive.maxInstallmentYearsMonths, '10 years');
        expect(propertyHive.isFavorite, true);
      });

      test('should handle null optional fields correctly', () {
        final entity = Property(
          id: 1,
          name: 'Test Property',
          slug: null,
          image: null,
          finishing: null,
          minUnitArea: null,
          maxUnitArea: null,
          minPrice: null,
          maxPrice: null,
          currency: null,
          maxInstallmentYears: null,
          maxInstallmentYearsMonths: null,
          isFavorite: true,
        );

        final propertyHive = PropertyHive.fromEntity(entity);

        expect(propertyHive.propertyId, 1);
        expect(propertyHive.name, 'Test Property');
        expect(propertyHive.slug, isNull);
        expect(propertyHive.image, isNull);
        expect(propertyHive.finishing, isNull);
        expect(propertyHive.minUnitArea, isNull);
        expect(propertyHive.maxUnitArea, isNull);
        expect(propertyHive.minPrice, isNull);
        expect(propertyHive.maxPrice, isNull);
        expect(propertyHive.currency, isNull);
        expect(propertyHive.maxInstallmentYears, isNull);
        expect(propertyHive.maxInstallmentYearsMonths, isNull);
        expect(propertyHive.isFavorite, true);
      });
    });

    group('Round-trip conversion', () {
      test('should maintain data integrity through round-trip conversion', () {
        final originalEntity = Property(
          id: 1,
          name: 'Test Property',
          slug: 'test-property',
          image: 'test-image.jpg',
          finishing: 'Finished',
          minUnitArea: 100.0,
          maxUnitArea: 200.0,
          minPrice: 1000000.0,
          maxPrice: 2000000.0,
          currency: 'EGP',
          maxInstallmentYears: 10,
          maxInstallmentYearsMonths: '10 years',
          isFavorite: true,
        );

        // Entity -> Hive -> Entity
        final propertyHive = PropertyHive.fromEntity(originalEntity);
        final convertedEntity = propertyHive.toEntity();

        expect(convertedEntity.id, originalEntity.id);
        expect(convertedEntity.name, originalEntity.name);
        expect(convertedEntity.slug, originalEntity.slug);
        expect(convertedEntity.image, originalEntity.image);
        expect(convertedEntity.finishing, originalEntity.finishing);
        expect(convertedEntity.minUnitArea, originalEntity.minUnitArea);
        expect(convertedEntity.maxUnitArea, originalEntity.maxUnitArea);
        expect(convertedEntity.minPrice, originalEntity.minPrice);
        expect(convertedEntity.maxPrice, originalEntity.maxPrice);
        expect(convertedEntity.currency, originalEntity.currency);
        expect(convertedEntity.maxInstallmentYears, originalEntity.maxInstallmentYears);
        expect(convertedEntity.maxInstallmentYearsMonths, originalEntity.maxInstallmentYearsMonths);
        expect(convertedEntity.isFavorite, originalEntity.isFavorite);
      });
    });
  });
}
