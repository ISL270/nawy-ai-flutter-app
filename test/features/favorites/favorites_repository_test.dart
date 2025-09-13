import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/features/favorites/data/favorites_repository.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/favorites_local_source.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';

class MockFavoritesLocalSource extends Mock implements FavoritesLocalSource {}

// Fake classes for fallback values
class FakeProperty extends Fake implements Property {}
class FakeCompound extends Fake implements Compound {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProperty());
    registerFallbackValue(FakeCompound());
  });
  group('FavoritesRepository', () {
    late FavoritesRepository repository;
    late MockFavoritesLocalSource mockLocalSource;

    setUp(() {
      mockLocalSource = MockFavoritesLocalSource();
      repository = FavoritesRepository(mockLocalSource);
    });

    group('Property Favorites', () {
      test('should return favorite properties from local source', () async {
        final testProperties = [
          Property(id: 1, name: 'Property 1', isFavorite: true),
          Property(id: 2, name: 'Property 2', isFavorite: true),
        ];

        when(() => mockLocalSource.getFavoriteProperties())
            .thenAnswer((_) async => testProperties);

        final result = await repository.getFavoriteProperties();

        expect(result, equals(testProperties));
        verify(() => mockLocalSource.getFavoriteProperties()).called(1);
      });

      test('should add property to favorites via local source', () async {
        final property = Property(id: 1, name: 'Test Property', isFavorite: false);

        when(() => mockLocalSource.addFavoriteProperty(property))
            .thenAnswer((_) async {});

        await repository.addFavoriteProperty(property);

        verify(() => mockLocalSource.addFavoriteProperty(property)).called(1);
      });

      test('should remove property from favorites via local source', () async {
        const propertyId = 1;

        when(() => mockLocalSource.removeFavoriteProperty(propertyId))
            .thenAnswer((_) async {});

        await repository.removeFavoriteProperty(propertyId);

        verify(() => mockLocalSource.removeFavoriteProperty(propertyId)).called(1);
      });

      test('should check if property is favorite via local source', () async {
        const propertyId = 1;

        when(() => mockLocalSource.isPropertyFavorite(propertyId))
            .thenAnswer((_) async => true);

        final result = await repository.isPropertyFavorite(propertyId);

        expect(result, isTrue);
        verify(() => mockLocalSource.isPropertyFavorite(propertyId)).called(1);
      });

      test('should return false when property is not favorite', () async {
        const propertyId = 999;

        when(() => mockLocalSource.isPropertyFavorite(propertyId))
            .thenAnswer((_) async => false);

        final result = await repository.isPropertyFavorite(propertyId);

        expect(result, isFalse);
        verify(() => mockLocalSource.isPropertyFavorite(propertyId)).called(1);
      });
    });

    group('Compound Favorites', () {
      test('should return favorite compounds from local source', () async {
        final testCompounds = [
          const Compound(
            id: 1,
            areaId: 1,
            name: 'Compound 1',
            hasOffers: false,
            isFavorite: true,
          ),
          const Compound(
            id: 2,
            areaId: 2,
            name: 'Compound 2',
            hasOffers: true,
            isFavorite: true,
          ),
        ];

        when(() => mockLocalSource.getFavoriteCompounds())
            .thenAnswer((_) async => testCompounds);

        final result = await repository.getFavoriteCompounds();

        expect(result, equals(testCompounds));
        verify(() => mockLocalSource.getFavoriteCompounds()).called(1);
      });

      test('should add compound to favorites via local source', () async {
        const compound = Compound(
          id: 1,
          areaId: 1,
          name: 'Test Compound',
          hasOffers: false,
          isFavorite: false,
        );

        when(() => mockLocalSource.addFavoriteCompound(compound))
            .thenAnswer((_) async {});

        await repository.addFavoriteCompound(compound);

        verify(() => mockLocalSource.addFavoriteCompound(compound)).called(1);
      });

      test('should remove compound from favorites via local source', () async {
        const compoundId = 1;

        when(() => mockLocalSource.removeFavoriteCompound(compoundId))
            .thenAnswer((_) async {});

        await repository.removeFavoriteCompound(compoundId);

        verify(() => mockLocalSource.removeFavoriteCompound(compoundId)).called(1);
      });

      test('should check if compound is favorite via local source', () async {
        const compoundId = 1;

        when(() => mockLocalSource.isCompoundFavorite(compoundId))
            .thenAnswer((_) async => true);

        final result = await repository.isCompoundFavorite(compoundId);

        expect(result, isTrue);
        verify(() => mockLocalSource.isCompoundFavorite(compoundId)).called(1);
      });

      test('should return false when compound is not favorite', () async {
        const compoundId = 999;

        when(() => mockLocalSource.isCompoundFavorite(compoundId))
            .thenAnswer((_) async => false);

        final result = await repository.isCompoundFavorite(compoundId);

        expect(result, isFalse);
        verify(() => mockLocalSource.isCompoundFavorite(compoundId)).called(1);
      });
    });

    group('Error Handling', () {
      test('should propagate exceptions from local source for properties', () async {
        when(() => mockLocalSource.getFavoriteProperties())
            .thenThrow(Exception('Database error'));

        expect(
          () => repository.getFavoriteProperties(),
          throwsException,
        );
      });

      test('should propagate exceptions from local source for compounds', () async {
        when(() => mockLocalSource.getFavoriteCompounds())
            .thenThrow(Exception('Database error'));

        expect(
          () => repository.getFavoriteCompounds(),
          throwsException,
        );
      });

      test('should propagate exceptions when adding property favorite', () async {
        final property = Property(id: 1, name: 'Test Property', isFavorite: false);

        when(() => mockLocalSource.addFavoriteProperty(property))
            .thenThrow(Exception('Database error'));

        expect(
          () => repository.addFavoriteProperty(property),
          throwsException,
        );
      });

      test('should propagate exceptions when removing property favorite', () async {
        when(() => mockLocalSource.removeFavoriteProperty(1))
            .thenThrow(Exception('Database error'));

        expect(
          () => repository.removeFavoriteProperty(1),
          throwsException,
        );
      });

      test('should propagate exceptions when checking property favorite status', () async {
        when(() => mockLocalSource.isPropertyFavorite(1))
            .thenThrow(Exception('Database error'));

        expect(
          () => repository.isPropertyFavorite(1),
          throwsException,
        );
      });
    });

    group('Repository Contract', () {
      test('should be properly injectable as singleton', () {
        expect(repository, isA<FavoritesRepository>());
        expect(repository.runtimeType.toString(), equals('FavoritesRepository'));
      });

      test('should maintain local source dependency', () async {
        // Mock the return value to avoid null subtype error
        when(() => mockLocalSource.getFavoriteProperties())
            .thenAnswer((_) async => []);
        
        // Verify the repository maintains its dependency
        final result = await repository.getFavoriteProperties();
        expect(result, isA<List<Property>>());
      });

      test('should handle empty results gracefully', () async {
        when(() => mockLocalSource.getFavoriteProperties())
            .thenAnswer((_) async => []);
        when(() => mockLocalSource.getFavoriteCompounds())
            .thenAnswer((_) async => []);

        final properties = await repository.getFavoriteProperties();
        final compounds = await repository.getFavoriteCompounds();

        expect(properties, isEmpty);
        expect(compounds, isEmpty);
      });
    });

    group('Data Consistency', () {
      test('should handle concurrent operations correctly', () async {
        final property1 = Property(id: 1, name: 'Property 1', isFavorite: false);
        final property2 = Property(id: 2, name: 'Property 2', isFavorite: false);

        when(() => mockLocalSource.addFavoriteProperty(any()))
            .thenAnswer((_) async {});

        // Simulate concurrent operations
        final futures = [
          repository.addFavoriteProperty(property1),
          repository.addFavoriteProperty(property2),
        ];

        await Future.wait(futures);

        verify(() => mockLocalSource.addFavoriteProperty(property1)).called(1);
        verify(() => mockLocalSource.addFavoriteProperty(property2)).called(1);
      });

      test('should handle large datasets efficiently', () async {
        final largePropertyList = List.generate(
          1000,
          (index) => Property(id: index, name: 'Property $index', isFavorite: true),
        );

        when(() => mockLocalSource.getFavoriteProperties())
            .thenAnswer((_) async => largePropertyList);

        final result = await repository.getFavoriteProperties();

        expect(result, hasLength(1000));
        expect(result.first.name, equals('Property 0'));
        expect(result.last.name, equals('Property 999'));
      });
    });
  });
}
