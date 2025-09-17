import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_ai_app/app/core/models/status.dart';
import 'package:nawy_ai_app/app/core/utils/app_logger.dart';
import 'package:nawy_ai_app/app/core/utils/error_handler.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/area.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/property_filters.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/property_search_repository.dart';
import 'package:nawy_ai_app/app/features/property_search/presentation/bloc/property_search_bloc_exports.dart';

class MockPropertySearchRepository extends Mock implements PropertySearchRepository {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  group('PropertySearchBloc', () {
    late PropertySearchBloc searchBloc;
    late MockPropertySearchRepository mockRepository;

    // Test data
    final testAreas = <Area>[
      const Area(id: 1, name: 'New Cairo'),
      const Area(id: 2, name: 'Sheikh Zayed'),
    ];

    final testCompounds = <Compound>[
      const Compound(id: 1, name: 'Compound A', areaId: 1, hasOffers: true),
    ];

    final testFilterOptions = FilterOptions(
      minBedrooms: 1,
      maxBedrooms: 5,
      minPriceList: const [100000, 200000],
      maxPriceList: const [500000, 1000000],
    );

    final testSearchResponse = PropertySearchResponse(
      totalCompounds: 10,
      totalProperties: 50,
      totalPropertyGroups: 25,
      properties: const [],
    );

    const testFilters = PropertyFilters(selectedAreaIds: [1], minPrice: 100000, maxPrice: 500000);

    setUp(() {
      mockRepository = MockPropertySearchRepository();
      searchBloc = PropertySearchBloc(mockRepository);
    });

    tearDown(() {
      searchBloc.close();
    });

    test('initial state should be correct', () {
      expect(searchBloc.state, equals(PropertySearchState.initial()));
      expect(searchBloc.state.status, isA<Initial>());
      expect(searchBloc.state.currentFilters, equals(const PropertyFilters()));
      expect(searchBloc.state.initialData, isNull);
      expect(searchBloc.state.searchResults, isNull);
    });

    group('LoadInitialDataEvent', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'emits loading then success when data loads successfully',
        build: () {
          when(() => mockRepository.getAreas()).thenAnswer((_) async => testAreas);
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        expect: () => [
          PropertySearchState.initial().copyWith(status: const Loading()),
          PropertySearchState.initial().copyWith(
            status: const Success(null),
            initialData: InitialData(
              areas: testAreas,
              compounds: testCompounds,
              filterOptions: testFilterOptions,
            ),
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.getAreas()).called(1);
          verify(() => mockRepository.getCompounds()).called(1);
          verify(() => mockRepository.getFilterOptions()).called(1);
        },
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'emits loading then failure when data loading fails',
        build: () {
          when(() => mockRepository.getAreas()).thenThrow(Exception('Network error'));
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(bloc.state.errorMessage, equals('Something went wrong. Please try again.'));
        },
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'emits network error message for SocketException',
        build: () {
          when(() => mockRepository.getAreas()).thenThrow(
            AppException(
              'No internet connection. Please check your network and try again.',
              SocketException('Network unreachable'),
            ),
          );
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(
            bloc.state.errorMessage,
            equals('No internet connection. Please check your network and try again.'),
          );
        },
      );
    });

    group('SearchPropertiesEvent', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'emits loading then success when search completes successfully',
        build: () {
          when(
            () => mockRepository.searchProperties(
              areaIds: any(named: 'areaIds'),
              compoundIds: any(named: 'compoundIds'),
              minPrice: any(named: 'minPrice'),
              maxPrice: any(named: 'maxPrice'),
              minBedrooms: any(named: 'minBedrooms'),
              maxBedrooms: any(named: 'maxBedrooms'),
              propertyTypeIds: any(named: 'propertyTypeIds'),
            ),
          ).thenAnswer((_) async => testSearchResponse);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(testFilters)),
        expect: () => [
          PropertySearchState.initial().copyWith(
            status: const Loading(),
            currentFilters: testFilters,
          ),
          PropertySearchState.initial().copyWith(
            status: const Success(null),
            currentFilters: testFilters,
            searchResults: testSearchResponse,
          ),
        ],
        verify: (_) {
          verify(
            () => mockRepository.searchProperties(
              areaIds: [1],
              compoundIds: null,
              minPrice: 100000,
              maxPrice: 500000,
              minBedrooms: null,
              maxBedrooms: null,
              propertyTypeIds: null,
            ),
          ).called(1);
        },
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'emits loading then failure when search fails',
        build: () {
          when(
            () => mockRepository.searchProperties(
              areaIds: any(named: 'areaIds'),
              compoundIds: any(named: 'compoundIds'),
              minPrice: any(named: 'minPrice'),
              maxPrice: any(named: 'maxPrice'),
              minBedrooms: any(named: 'minBedrooms'),
              maxBedrooms: any(named: 'maxBedrooms'),
              propertyTypeIds: any(named: 'propertyTypeIds'),
            ),
          ).thenThrow(
            AppException(
              'Request timed out. Please try again.',
              TimeoutException('Request timeout', const Duration(seconds: 30)),
            ),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(testFilters)),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(bloc.state.errorMessage, equals('Request timed out. Please try again.'));
          expect(bloc.state.currentFilters, equals(testFilters));
        },
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'handles empty filter lists correctly by passing null',
        build: () {
          when(
            () => mockRepository.searchProperties(
              areaIds: any(named: 'areaIds'),
              compoundIds: any(named: 'compoundIds'),
              minPrice: any(named: 'minPrice'),
              maxPrice: any(named: 'maxPrice'),
              minBedrooms: any(named: 'minBedrooms'),
              maxBedrooms: any(named: 'maxBedrooms'),
              propertyTypeIds: any(named: 'propertyTypeIds'),
            ),
          ).thenAnswer((_) async => testSearchResponse);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(PropertyFilters())),
        expect: () => [
          PropertySearchState.initial().copyWith(
            status: const Loading(),
            currentFilters: const PropertyFilters(),
          ),
          PropertySearchState.initial().copyWith(
            status: const Success(null),
            currentFilters: const PropertyFilters(),
            searchResults: testSearchResponse,
          ),
        ],
        verify: (_) {
          verify(
            () => mockRepository.searchProperties(
              areaIds: null,
              compoundIds: null,
              minPrice: null,
              maxPrice: null,
              minBedrooms: null,
              maxBedrooms: null,
              propertyTypeIds: null,
            ),
          ).called(1);
        },
      );
    });

    group('UpdateFiltersEvent', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'with active search query updates filters and searches',
        build: () => searchBloc,
        seed: () => PropertySearchState.initial().copyWith(
          searchQuery: 'test',
          currentFilters: const PropertyFilters(),
        ),
        act: (bloc) => bloc.add(UpdateFiltersEvent(testFilters)),
        expect: () => [
          // Loading state with new filters
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Loading>())
              .having((s) => s.searchQuery, 'searchQuery', 'test')
              .having((s) => s.currentFilters, 'currentFilters', testFilters),
          // Failure state because we didn't mock the repository
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Failure>())
              .having((s) => s.searchQuery, 'searchQuery', 'test')
              .having((s) => s.currentFilters, 'currentFilters', testFilters),
        ],
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'without search query updates filters and searches',
        build: () => searchBloc,
        seed: () => PropertySearchState.initial().copyWith(
          searchQuery: null,
          currentFilters: const PropertyFilters(),
        ),
        act: (bloc) => bloc.add(UpdateFiltersEvent(testFilters)),
        expect: () => [
          // Loading state with new filters
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Loading>())
              .having((s) => s.searchQuery, 'searchQuery', isNull)
              .having((s) => s.currentFilters, 'currentFilters', testFilters),
          // Failure state because we didn't mock the repository
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Failure>())
              .having((s) => s.searchQuery, 'searchQuery', isNull)
              .having((s) => s.currentFilters, 'currentFilters', testFilters),
        ],
      );
    });

    group('ClearFiltersEvent', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'with active search query clears filters and searches',
        build: () => searchBloc,
        seed: () => PropertySearchState.initial().copyWith(
          searchQuery: 'test',
          currentFilters: testFilters,
        ),
        act: (bloc) => bloc.add(const ClearFiltersEvent()),
        expect: () => [
          // Loading state with cleared filters
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Loading>())
              .having((s) => s.searchQuery, 'searchQuery', 'test')
              .having((s) => s.currentFilters, 'currentFilters', const PropertyFilters()),
          // Failure state because we didn't mock the repository
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Failure>())
              .having((s) => s.searchQuery, 'searchQuery', 'test')
              .having((s) => s.currentFilters, 'currentFilters', const PropertyFilters()),
        ],
      );

      blocTest<PropertySearchBloc, PropertySearchState>(
        'without search query clears filters and searches',
        build: () => searchBloc,
        seed: () => PropertySearchState.initial().copyWith(
          searchQuery: null,
          currentFilters: testFilters,
        ),
        act: (bloc) => bloc.add(const ClearFiltersEvent()),
        expect: () => [
          // Updates the state with cleared filters
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Initial>())
              .having((s) => s.searchQuery, 'searchQuery', isNull)
              .having((s) => s.currentFilters, 'currentFilters', const PropertyFilters()),
          // Loading state for the search
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Loading>())
              .having((s) => s.searchQuery, 'searchQuery', isNull)
              .having((s) => s.currentFilters, 'currentFilters', const PropertyFilters()),
          // Failure state because we didn't mock the repository
          isA<PropertySearchState>()
              .having((s) => s.status, 'status', isA<Failure>())
              .having((s) => s.searchQuery, 'searchQuery', isNull)
              .having((s) => s.currentFilters, 'currentFilters', const PropertyFilters()),
        ],
      );
    });

    group('ResetSearchEvent', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'resets entire search state',
        build: () => searchBloc,
        seed: () => PropertySearchState.initial().copyWith(
          status: const Success(null),
          currentFilters: testFilters,
          searchResults: testSearchResponse,
        ),
        act: (bloc) => bloc.add(const ResetSearchEvent()),
        expect: () => [PropertySearchState.initial()],
      );
    });

    group('Error handling', () {
      blocTest<PropertySearchBloc, PropertySearchState>(
        'handles FormatException with appropriate message',
        build: () {
          when(() => mockRepository.getAreas()).thenThrow(
            AppException(
              'Invalid data received from server. Please try again.',
              const FormatException('Invalid JSON'),
            ),
          );
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(
            bloc.state.errorMessage,
            equals('Invalid data received from server. Please try again.'),
          );
        },
      );
    });

    group('State convenience getters', () {
      test('isLoading returns correct value', () {
        final loadingState = PropertySearchState.initial().copyWith(status: const Loading());
        expect(loadingState.isLoading, isTrue);

        final successState = PropertySearchState.initial().copyWith(status: const Success(null));
        expect(successState.isLoading, isFalse);
      });

      test('hasError returns correct value', () {
        final errorState = PropertySearchState.initial().copyWith(
          status: Failure('Error', Exception('test')),
        );
        expect(errorState.hasError, isTrue);

        final successState = PropertySearchState.initial().copyWith(status: const Success(null));
        expect(successState.hasError, isFalse);
      });

      test('hasInitialData returns correct value', () {
        final stateWithData = PropertySearchState.initial().copyWith(
          initialData: InitialData(
            areas: testAreas,
            compounds: testCompounds,
            filterOptions: testFilterOptions,
          ),
        );
        expect(stateWithData.hasInitialData, isTrue);

        final stateWithoutData = PropertySearchState.initial();
        expect(stateWithoutData.hasInitialData, isFalse);
      });

      test('hasSearchResults returns correct value', () {
        final stateWithResults = PropertySearchState.initial().copyWith(
          searchResults: testSearchResponse,
        );
        expect(stateWithResults.hasSearchResults, isTrue);

        final stateWithoutResults = PropertySearchState.initial();
        expect(stateWithoutResults.hasSearchResults, isFalse);
      });

      test('hasFiltersApplied returns correct value', () {
        final stateWithFilters = PropertySearchState.initial().copyWith(
          currentFilters: testFilters,
        );
        expect(stateWithFilters.hasFiltersApplied, isTrue);

        final stateWithoutFilters = PropertySearchState.initial();
        expect(stateWithoutFilters.hasFiltersApplied, isFalse);
      });

      test('errorMessage returns correct value', () {
        const errorMessage = 'Test error message';
        final errorState = PropertySearchState.initial().copyWith(
          status: Failure(errorMessage, Exception('test')),
        );
        expect(errorState.errorMessage, equals(errorMessage));

        final successState = PropertySearchState.initial().copyWith(status: const Success(null));
        expect(successState.errorMessage, isNull);
      });
    });
  });
}
