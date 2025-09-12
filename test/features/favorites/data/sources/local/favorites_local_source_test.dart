import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/utils/hive_service.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/favorites_local_source.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/compound_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_hive.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property.dart';

class MockHiveService extends Mock implements HiveService {}
class MockPropertyBox extends Mock implements Box<PropertyHive> {}
class MockCompoundBox extends Mock implements Box<CompoundHive> {}

class FakePropertyHive extends Fake implements PropertyHive {}
class FakeCompoundHive extends Fake implements CompoundHive {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePropertyHive());
    registerFallbackValue(FakeCompoundHive());
  });
  group('FavoritesLocalSource', () {
    late FavoritesLocalSource localSource;
    late MockHiveService mockHiveService;
    late MockPropertyBox mockPropertyBox;
    late MockCompoundBox mockCompoundBox;

    setUp(() {
      mockHiveService = MockHiveService();
      mockPropertyBox = MockPropertyBox();
      mockCompoundBox = MockCompoundBox();
      
      when(() => mockHiveService.propertyBox).thenReturn(mockPropertyBox);
      when(() => mockHiveService.compoundBox).thenReturn(mockCompoundBox);
      
      localSource = FavoritesLocalSource(mockHiveService);
    });

    group('Property Favorites', () {
      test('should return empty list when no favorite properties exist', () async {
        when(() => mockPropertyBox.values).thenReturn([]);

        final result = await localSource.getFavoriteProperties();

        expect(result, isEmpty);
        verify(() => mockPropertyBox.values).called(1);
      });

      test('should return list of favorite properties', () async {
        final propertyHive = PropertyHive()
          ..propertyId = 1
          ..name = 'Test Property'
          ..isFavorite = true;

        when(() => mockPropertyBox.values).thenReturn([propertyHive]);

        final result = await localSource.getFavoriteProperties();

        expect(result, hasLength(1));
        expect(result.first.id, 1);
        expect(result.first.name, 'Test Property');
        expect(result.first.isFavorite, true);
        verify(() => mockPropertyBox.values).called(1);
      });

      test('should add property to favorites successfully', () async {
        final property = Property(
          id: 1,
          name: 'Test Property',
          isFavorite: false,
        );

        when(() => mockPropertyBox.containsKey('property_1')).thenReturn(false);
        when(() => mockPropertyBox.put(any(), any())).thenAnswer((_) async {});

        await localSource.addFavoriteProperty(property);

        verify(() => mockPropertyBox.containsKey('property_1')).called(1);
        verify(() => mockPropertyBox.put('property_1', any())).called(1);
      });

      test('should not add property if already exists in favorites', () async {
        final property = Property(
          id: 1,
          name: 'Test Property',
          isFavorite: false,
        );

        when(() => mockPropertyBox.containsKey('property_1')).thenReturn(true);

        await localSource.addFavoriteProperty(property);

        verify(() => mockPropertyBox.containsKey('property_1')).called(1);
        verifyNever(() => mockPropertyBox.put(any(), any()));
      });

      test('should remove property from favorites successfully', () async {
        when(() => mockPropertyBox.delete('property_1')).thenAnswer((_) async {});

        await localSource.removeFavoriteProperty(1);

        verify(() => mockPropertyBox.delete('property_1')).called(1);
      });

      test('should check if property is favorite correctly', () async {
        when(() => mockPropertyBox.containsKey('property_1')).thenReturn(true);

        final result = await localSource.isPropertyFavorite(1);

        expect(result, true);
        verify(() => mockPropertyBox.containsKey('property_1')).called(1);
      });

      test('should return false for non-favorite property', () async {
        when(() => mockPropertyBox.containsKey('property_999')).thenReturn(false);

        final result = await localSource.isPropertyFavorite(999);

        expect(result, false);
        verify(() => mockPropertyBox.containsKey('property_999')).called(1);
      });
    });

    group('Compound Favorites', () {
      test('should return empty list when no favorite compounds exist', () async {
        when(() => mockCompoundBox.values).thenReturn([]);

        final result = await localSource.getFavoriteCompounds();

        expect(result, isEmpty);
        verify(() => mockCompoundBox.values).called(1);
      });

      test('should return list of favorite compounds', () async {
        final compoundHive = CompoundHive()
          ..compoundId = 1
          ..areaId = 2
          ..name = 'Test Compound'
          ..isFavorite = true;

        when(() => mockCompoundBox.values).thenReturn([compoundHive]);

        final result = await localSource.getFavoriteCompounds();

        expect(result, hasLength(1));
        expect(result.first.id, 1);
        expect(result.first.name, 'Test Compound');
        expect(result.first.isFavorite, true);
        verify(() => mockCompoundBox.values).called(1);
      });

      test('should add compound to favorites successfully', () async {
        final compound = Compound(
          id: 1,
          areaId: 2,
          name: 'Test Compound',
          hasOffers: false,
          isFavorite: false,
        );

        when(() => mockCompoundBox.containsKey('compound_1')).thenReturn(false);
        when(() => mockCompoundBox.put(any(), any())).thenAnswer((_) async {});

        await localSource.addFavoriteCompound(compound);

        verify(() => mockCompoundBox.containsKey('compound_1')).called(1);
        verify(() => mockCompoundBox.put('compound_1', any())).called(1);
      });

      test('should not add compound if already exists in favorites', () async {
        final compound = Compound(
          id: 1,
          areaId: 2,
          name: 'Test Compound',
          hasOffers: false,
          isFavorite: false,
        );

        when(() => mockCompoundBox.containsKey('compound_1')).thenReturn(true);

        await localSource.addFavoriteCompound(compound);

        verify(() => mockCompoundBox.containsKey('compound_1')).called(1);
        verifyNever(() => mockCompoundBox.put(any(), any()));
      });

      test('should remove compound from favorites successfully', () async {
        when(() => mockCompoundBox.delete('compound_1')).thenAnswer((_) async {});

        await localSource.removeFavoriteCompound(1);

        verify(() => mockCompoundBox.delete('compound_1')).called(1);
      });

      test('should check if compound is favorite correctly', () async {
        when(() => mockCompoundBox.containsKey('compound_1')).thenReturn(true);

        final result = await localSource.isCompoundFavorite(1);

        expect(result, true);
        verify(() => mockCompoundBox.containsKey('compound_1')).called(1);
      });

      test('should return false for non-favorite compound', () async {
        when(() => mockCompoundBox.containsKey('compound_999')).thenReturn(false);

        final result = await localSource.isCompoundFavorite(999);

        expect(result, false);
        verify(() => mockCompoundBox.containsKey('compound_999')).called(1);
      });
    });

    group('Error Handling', () {
      test('should handle exceptions in getFavoriteProperties gracefully', () async {
        when(() => mockPropertyBox.values).thenThrow(Exception('Database error'));

        expect(() => localSource.getFavoriteProperties(), throwsException);
      });

      test('should handle exceptions in addFavoriteProperty gracefully', () async {
        final property = Property(id: 1, name: 'Test Property', isFavorite: false);
        
        when(() => mockPropertyBox.containsKey(any())).thenThrow(Exception('Database error'));

        expect(() => localSource.addFavoriteProperty(property), throwsException);
      });

      test('should handle exceptions in getFavoriteCompounds gracefully', () async {
        when(() => mockCompoundBox.values).thenThrow(Exception('Database error'));

        expect(() => localSource.getFavoriteCompounds(), throwsException);
      });

      test('should handle exceptions in addFavoriteCompound gracefully', () async {
        final compound = Compound(
          id: 1,
          areaId: 2,
          name: 'Test Compound',
          hasOffers: false,
          isFavorite: false,
        );
        
        when(() => mockCompoundBox.containsKey(any())).thenThrow(Exception('Database error'));

        expect(() => localSource.addFavoriteCompound(compound), throwsException);
      });
    });
  });
}
