import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_ai_app/app/core/models/status.dart';
import 'package:nawy_ai_app/app/core/utils/app_logger.dart';
import 'package:nawy_ai_app/app/features/favorites/data/favorites_repository.dart';
import 'package:nawy_ai_app/app/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:nawy_ai_app/app/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:nawy_ai_app/app/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/property.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/compound.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}
class MockAppLogger extends Mock implements AppLogger {}

// Fake classes for fallback values
class FakeProperty extends Fake implements Property {}
class FakeCompound extends Fake implements Compound {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProperty());
    registerFallbackValue(FakeCompound());
  });
  group('FavoritesBloc', () {
    late FavoritesBloc bloc;
    late MockFavoritesRepository mockRepository;
    late MockAppLogger mockLogger;

    // Test data
    final testProperties = [
      Property(id: 1, name: 'Property 1', isFavorite: true),
      Property(id: 2, name: 'Property 2', isFavorite: true),
    ];

    final testCompounds = [
      const Compound(id: 1, areaId: 1, name: 'Compound 1', hasOffers: false, isFavorite: true),
      const Compound(id: 2, areaId: 2, name: 'Compound 2', hasOffers: true, isFavorite: true),
    ];

    setUp(() {
      mockRepository = MockFavoritesRepository();
      mockLogger = MockAppLogger();
      bloc = FavoritesBloc(mockRepository, mockLogger);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should be correct', () {
      expect(bloc.state, equals(FavoritesState.initial()));
      expect(bloc.state.status, isA<Initial>());
      expect(bloc.state.favoriteProperties, isEmpty);
      expect(bloc.state.favoriteCompounds, isEmpty);
      expect(bloc.state.favoritePropertyIds, isEmpty);
      expect(bloc.state.favoriteCompoundIds, isEmpty);
      expect(bloc.state.isLoading, false);
      expect(bloc.state.hasError, false);
      expect(bloc.state.hasData, false);
      expect(bloc.state.errorMessage, isNull);
    });

    group('LoadFavoritesEvent', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emits loading then success when favorites load successfully',
        build: () {
          when(() => mockRepository.getFavoriteProperties())
              .thenAnswer((_) async => testProperties);
          when(() => mockRepository.getFavoriteCompounds())
              .thenAnswer((_) async => testCompounds);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadFavoritesEvent()),
        expect: () => [
          FavoritesState.initial().copyWith(status: const Loading()),
          FavoritesState.initial().copyWith(
            status: const Success(null),
            favoriteProperties: testProperties,
            favoriteCompounds: testCompounds,
            favoritePropertyIds: {1, 2},
            favoriteCompoundIds: {1, 2},
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.getFavoriteProperties()).called(1);
          verify(() => mockRepository.getFavoriteCompounds()).called(1);
          verify(() => mockLogger.debug('Loading favorites')).called(1);
          verify(() => mockLogger.debug('Loaded 2 favorite properties and 2 favorite compounds')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits loading then failure when loading fails',
        build: () {
          when(() => mockRepository.getFavoriteProperties())
              .thenThrow(Exception('Database error'));
          when(() => mockRepository.getFavoriteCompounds())
              .thenAnswer((_) async => testCompounds);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadFavoritesEvent()),
        expect: () => [
          FavoritesState.initial().copyWith(status: const Loading()),
          FavoritesState.initial().copyWith(
            status: const Failure('Failed to load favorites. Please try again.'),
            errorMessage: 'Failed to load favorites. Please try again.',
          ),
        ],
        verify: (_) {
          verify(() => mockLogger.error('Error loading favorites: Exception: Database error')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'handles empty favorites list correctly',
        build: () {
          when(() => mockRepository.getFavoriteProperties())
              .thenAnswer((_) async => []);
          when(() => mockRepository.getFavoriteCompounds())
              .thenAnswer((_) async => []);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadFavoritesEvent()),
        expect: () => [
          FavoritesState.initial().copyWith(status: const Loading()),
          FavoritesState.initial().copyWith(
            status: const Success(null),
            favoriteProperties: [],
            favoriteCompounds: [],
            favoritePropertyIds: <int>{},
            favoriteCompoundIds: <int>{},
          ),
        ],
        verify: (_) {
          verify(() => mockLogger.debug('Loaded 0 favorite properties and 0 favorite compounds')).called(1);
        },
      );
    });

    group('TogglePropertyFavoriteEvent', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'adds property to favorites when not currently favorite',
        build: () {
          when(() => mockRepository.addFavoriteProperty(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(
          favoriteProperties: [],
          favoritePropertyIds: <int>{},
        ),
        act: (bloc) => bloc.add(TogglePropertyFavoriteEvent(testProperties.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteProperties: [testProperties.first],
            favoritePropertyIds: {1},
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.addFavoriteProperty(testProperties.first)).called(1);
          verify(() => mockLogger.debug('Toggling property 1 favorite status. Currently: false')).called(1);
          verify(() => mockLogger.debug('Added property 1 to favorites')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'removes property from favorites when currently favorite',
        build: () {
          when(() => mockRepository.removeFavoriteProperty(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(
          favoriteProperties: testProperties,
          favoritePropertyIds: {1, 2},
        ),
        act: (bloc) => bloc.add(TogglePropertyFavoriteEvent(testProperties.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteProperties: [testProperties.last],
            favoritePropertyIds: {2},
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.removeFavoriteProperty(1)).called(1);
          verify(() => mockLogger.debug('Toggling property 1 favorite status. Currently: true')).called(1);
          verify(() => mockLogger.debug('Removed property 1 from favorites')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits failure when toggle operation fails',
        build: () {
          when(() => mockRepository.addFavoriteProperty(any()))
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        seed: () => FavoritesState.initial(),
        act: (bloc) => bloc.add(TogglePropertyFavoriteEvent(testProperties.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            status: const Failure('Failed to update favorites. Please try again.'),
            errorMessage: 'Failed to update favorites. Please try again.',
          ),
        ],
        verify: (_) {
          verify(() => mockLogger.error('Error toggling property favorite: Exception: Database error')).called(1);
        },
      );
    });

    group('ToggleCompoundFavoriteEvent', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'adds compound to favorites when not currently favorite',
        build: () {
          when(() => mockRepository.addFavoriteCompound(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(
          favoriteCompounds: [],
          favoriteCompoundIds: <int>{},
        ),
        act: (bloc) => bloc.add(ToggleCompoundFavoriteEvent(testCompounds.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteCompounds: [testCompounds.first],
            favoriteCompoundIds: {1},
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.addFavoriteCompound(testCompounds.first)).called(1);
          verify(() => mockLogger.debug('Toggling compound 1 favorite status. Currently: false')).called(1);
          verify(() => mockLogger.debug('Added compound 1 to favorites')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'removes compound from favorites when currently favorite',
        build: () {
          when(() => mockRepository.removeFavoriteCompound(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(
          favoriteCompounds: testCompounds,
          favoriteCompoundIds: {1, 2},
        ),
        act: (bloc) => bloc.add(ToggleCompoundFavoriteEvent(testCompounds.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteCompounds: [testCompounds.last],
            favoriteCompoundIds: {2},
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.removeFavoriteCompound(1)).called(1);
          verify(() => mockLogger.debug('Toggling compound 1 favorite status. Currently: true')).called(1);
          verify(() => mockLogger.debug('Removed compound 1 from favorites')).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits failure when toggle operation fails',
        build: () {
          when(() => mockRepository.addFavoriteCompound(any()))
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        seed: () => FavoritesState.initial(),
        act: (bloc) => bloc.add(ToggleCompoundFavoriteEvent(testCompounds.first)),
        expect: () => [
          FavoritesState.initial().copyWith(
            status: const Failure('Failed to update favorites. Please try again.'),
            errorMessage: 'Failed to update favorites. Please try again.',
          ),
        ],
        verify: (_) {
          verify(() => mockLogger.error('Error toggling compound favorite: Exception: Database error')).called(1);
        },
      );
    });

    group('CheckPropertyFavoriteEvent', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'adds property ID to state when repository confirms it is favorite',
        build: () {
          when(() => mockRepository.isPropertyFavorite(1))
              .thenAnswer((_) async => true);
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(favoritePropertyIds: <int>{}),
        act: (bloc) => bloc.add(const CheckPropertyFavoriteEvent(1)),
        expect: () => [
          FavoritesState.initial().copyWith(favoritePropertyIds: {1}),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'removes property ID from state when repository confirms it is not favorite',
        build: () {
          when(() => mockRepository.isPropertyFavorite(1))
              .thenAnswer((_) async => false);
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(favoritePropertyIds: {1, 2}),
        act: (bloc) => bloc.add(const CheckPropertyFavoriteEvent(1)),
        expect: () => [
          FavoritesState.initial().copyWith(favoritePropertyIds: {2}),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'does not emit state when property status matches current state',
        build: () {
          when(() => mockRepository.isPropertyFavorite(1))
              .thenAnswer((_) async => true);
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(favoritePropertyIds: {1}),
        act: (bloc) => bloc.add(const CheckPropertyFavoriteEvent(1)),
        expect: () => [],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'handles errors gracefully without emitting state',
        build: () {
          when(() => mockRepository.isPropertyFavorite(1))
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const CheckPropertyFavoriteEvent(1)),
        expect: () => [],
        verify: (_) {
          verify(() => mockLogger.error('Error checking property favorite status: Exception: Database error')).called(1);
        },
      );
    });

    group('CheckCompoundFavoriteEvent', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'adds compound ID to state when repository confirms it is favorite',
        build: () {
          when(() => mockRepository.isCompoundFavorite(1))
              .thenAnswer((_) async => true);
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(favoriteCompoundIds: <int>{}),
        act: (bloc) => bloc.add(const CheckCompoundFavoriteEvent(1)),
        expect: () => [
          FavoritesState.initial().copyWith(favoriteCompoundIds: {1}),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'removes compound ID from state when repository confirms it is not favorite',
        build: () {
          when(() => mockRepository.isCompoundFavorite(1))
              .thenAnswer((_) async => false);
          return bloc;
        },
        seed: () => FavoritesState.initial().copyWith(favoriteCompoundIds: {1, 2}),
        act: (bloc) => bloc.add(const CheckCompoundFavoriteEvent(1)),
        expect: () => [
          FavoritesState.initial().copyWith(favoriteCompoundIds: {2}),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'handles errors gracefully without emitting state',
        build: () {
          when(() => mockRepository.isCompoundFavorite(1))
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const CheckCompoundFavoriteEvent(1)),
        expect: () => [],
        verify: (_) {
          verify(() => mockLogger.error('Error checking compound favorite status: Exception: Database error')).called(1);
        },
      );
    });

    group('State Convenience Methods', () {
      test('isPropertyFavorite returns correct value', () {
        final state = FavoritesState.initial().copyWith(favoritePropertyIds: {1, 3, 5});
        
        expect(state.isPropertyFavorite(1), isTrue);
        expect(state.isPropertyFavorite(2), isFalse);
        expect(state.isPropertyFavorite(3), isTrue);
        expect(state.isPropertyFavorite(999), isFalse);
      });

      test('isCompoundFavorite returns correct value', () {
        final state = FavoritesState.initial().copyWith(favoriteCompoundIds: {2, 4, 6});
        
        expect(state.isCompoundFavorite(2), isTrue);
        expect(state.isCompoundFavorite(3), isFalse);
        expect(state.isCompoundFavorite(4), isTrue);
        expect(state.isCompoundFavorite(999), isFalse);
      });

      test('hasData returns correct value', () {
        final emptyState = FavoritesState.initial();
        final withPropertiesState = FavoritesState.initial().copyWith(favoriteProperties: testProperties);
        final withCompoundsState = FavoritesState.initial().copyWith(favoriteCompounds: testCompounds);
        
        expect(emptyState.hasData, isFalse);
        expect(withPropertiesState.hasData, isTrue);
        expect(withCompoundsState.hasData, isTrue);
      });
    });

    group('State Equality', () {
      test('states with same properties should be equal', () {
        final state1 = FavoritesState.initial();
        final state2 = FavoritesState.initial();
        
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('states with different properties should not be equal', () {
        final state1 = FavoritesState.initial();
        final state2 = FavoritesState.initial().copyWith(status: const Loading());
        
        expect(state1, isNot(equals(state2)));
      });
    });

    group('Complex Scenarios', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'handles multiple rapid toggle operations correctly',
        build: () {
          when(() => mockRepository.addFavoriteProperty(any()))
              .thenAnswer((_) async {});
          when(() => mockRepository.removeFavoriteProperty(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial(),
        act: (bloc) {
          bloc.add(TogglePropertyFavoriteEvent(testProperties.first));
          bloc.add(TogglePropertyFavoriteEvent(testProperties.first));
        },
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteProperties: [testProperties.first],
            favoritePropertyIds: {1},
          ),
          FavoritesState.initial().copyWith(
            favoriteProperties: [],
            favoritePropertyIds: <int>{},
          ),
        ],
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'maintains state consistency during concurrent operations',
        build: () {
          when(() => mockRepository.addFavoriteProperty(any()))
              .thenAnswer((_) async {});
          when(() => mockRepository.addFavoriteCompound(any()))
              .thenAnswer((_) async {});
          return bloc;
        },
        seed: () => FavoritesState.initial(),
        act: (bloc) {
          bloc.add(TogglePropertyFavoriteEvent(testProperties.first));
          bloc.add(ToggleCompoundFavoriteEvent(testCompounds.first));
        },
        expect: () => [
          FavoritesState.initial().copyWith(
            favoriteProperties: [testProperties.first],
            favoritePropertyIds: {1},
          ),
          FavoritesState.initial().copyWith(
            favoriteProperties: [testProperties.first],
            favoriteCompounds: [testCompounds.first],
            favoritePropertyIds: {1},
            favoriteCompoundIds: {1},
          ),
        ],
      );
    });
  });
}
