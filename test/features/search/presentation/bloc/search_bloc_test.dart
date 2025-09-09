import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';
import 'package:nawy_app/app/features/search/domain/property_repository.dart';
import 'package:nawy_app/app/features/search/presentation/bloc/search_bloc_exports.dart';

class MockPropertyRepository extends Mock implements PropertyRepository {}
class MockAppLogger extends Mock implements AppLogger {}

void main() {
  group('SearchBloc', () {
    late SearchBloc searchBloc;
    late MockPropertyRepository mockRepository;
  
    // Test data
    final testAreas = <Area>[
      const Area(id: 1, name: 'New Cairo'),
      const Area(id: 2, name: 'Sheikh Zayed'),
    ];

    final testCompounds = <Compound>[
      const Compound(
        id: 1,
        name: 'Compound A',
        areaId: 1,
        hasOffers: true,
      ),
    ];

    final testFilterOptions = FilterOptions(
      minBedrooms: 1,
      maxBedrooms: 5,
      minPriceList: const [100000, 200000],
      maxPriceList: const [500000, 1000000],
    );

    final testSearchResponse = SearchResponse(
      totalCompounds: 10,
      totalProperties: 50,
      totalPropertyGroups: 25,
      properties: const [],
    );

    const testFilters = SearchFilters(
      selectedAreaIds: [1],
      minPrice: 100000,
      maxPrice: 500000,
    );

    setUp(() {
      mockRepository = MockPropertyRepository();
      searchBloc = SearchBloc(mockRepository);
    });

    tearDown(() {
      searchBloc.close();
    });

    test('initial state should be correct', () {
      expect(searchBloc.state, equals(SearchState.initial()));
      expect(searchBloc.state.status, isA<Initial>());
      expect(searchBloc.state.currentFilters, equals(const SearchFilters()));
      expect(searchBloc.state.initialData, isNull);
      expect(searchBloc.state.searchResults, isNull);
    });

    group('LoadInitialDataEvent', () {
      blocTest<SearchBloc, SearchState>(
        'emits loading then success when data loads successfully',
        build: () {
          when(() => mockRepository.getAreas()).thenAnswer((_) async => testAreas);
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        expect: () => [
          SearchState.initial().copyWith(status: const Loading()),
          SearchState.initial().copyWith(
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

      blocTest<SearchBloc, SearchState>(
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

      blocTest<SearchBloc, SearchState>(
        'emits network error message for SocketException',
        build: () {
          when(() => mockRepository.getAreas()).thenThrow(AppException(
            'No internet connection. Please check your network and try again.',
            SocketException('Network unreachable'),
          ));
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(bloc.state.errorMessage, equals('No internet connection. Please check your network and try again.'));
        },
      );
    });

    group('SearchPropertiesEvent', () {
      blocTest<SearchBloc, SearchState>(
        'emits loading then success when search completes successfully',
        build: () {
          when(() => mockRepository.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          )).thenAnswer((_) async => testSearchResponse);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(testFilters)),
        expect: () => [
          SearchState.initial().copyWith(
            status: const Loading(),
            currentFilters: testFilters,
          ),
          SearchState.initial().copyWith(
            status: const Success(null),
            currentFilters: testFilters,
            searchResults: testSearchResponse,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.searchProperties(
            areaIds: [1],
            compoundIds: null,
            minPrice: 100000,
            maxPrice: 500000,
            minBedrooms: null,
            maxBedrooms: null,
            propertyTypeIds: null,
          )).called(1);
        },
      );

      blocTest<SearchBloc, SearchState>(
        'emits loading then failure when search fails',
        build: () {
          when(() => mockRepository.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          )).thenThrow(AppException(
            'Request timed out. Please try again.',
            TimeoutException('Request timeout', const Duration(seconds: 30)),
          ));
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(testFilters)),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(bloc.state.errorMessage, equals('Request timed out. Please try again.'));
          expect(bloc.state.currentFilters, equals(testFilters));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'handles empty filter lists correctly by passing null',
        build: () {
          when(() => mockRepository.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          )).thenAnswer((_) async => testSearchResponse);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const SearchPropertiesEvent(SearchFilters())),
        expect: () => [
          SearchState.initial().copyWith(
            status: const Loading(),
            currentFilters: const SearchFilters(),
          ),
          SearchState.initial().copyWith(
            status: const Success(null),
            currentFilters: const SearchFilters(),
            searchResults: testSearchResponse,
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.searchProperties(
            areaIds: null,
            compoundIds: null,
            minPrice: null,
            maxPrice: null,
            minBedrooms: null,
            maxBedrooms: null,
            propertyTypeIds: null,
          )).called(1);
        },
      );
    });

    group('UpdateFiltersEvent', () {
      blocTest<SearchBloc, SearchState>(
        'updates filters without triggering search',
        build: () => searchBloc,
        act: (bloc) => bloc.add(const UpdateFiltersEvent(testFilters)),
        expect: () => [
          SearchState.initial().copyWith(currentFilters: testFilters),
        ],
        verify: (_) {
          verifyNever(() => mockRepository.searchProperties(
            areaIds: any(named: 'areaIds'),
            compoundIds: any(named: 'compoundIds'),
            minPrice: any(named: 'minPrice'),
            maxPrice: any(named: 'maxPrice'),
            minBedrooms: any(named: 'minBedrooms'),
            maxBedrooms: any(named: 'maxBedrooms'),
            propertyTypeIds: any(named: 'propertyTypeIds'),
          ));
        },
      );
    });

    group('ClearFiltersEvent', () {
      blocTest<SearchBloc, SearchState>(
        'clears all filters',
        build: () => searchBloc,
        seed: () => SearchState.initial().copyWith(currentFilters: testFilters),
        act: (bloc) => bloc.add(const ClearFiltersEvent()),
        expect: () => [
          SearchState.initial().copyWith(currentFilters: const SearchFilters()),
        ],
      );
    });

    group('ResetSearchEvent', () {
      blocTest<SearchBloc, SearchState>(
        'resets entire search state',
        build: () => searchBloc,
        seed: () => SearchState.initial().copyWith(
          status: const Success(null),
          currentFilters: testFilters,
          searchResults: testSearchResponse,
        ),
        act: (bloc) => bloc.add(const ResetSearchEvent()),
        expect: () => [SearchState.initial()],
      );
    });

    group('Error handling', () {
      blocTest<SearchBloc, SearchState>(
        'handles FormatException with appropriate message',
        build: () {
          when(() => mockRepository.getAreas()).thenThrow(AppException(
            'Invalid data received from server. Please try again.',
            const FormatException('Invalid JSON'),
          ));
          when(() => mockRepository.getCompounds()).thenAnswer((_) async => testCompounds);
          when(() => mockRepository.getFilterOptions()).thenAnswer((_) async => testFilterOptions);
          return searchBloc;
        },
        act: (bloc) => bloc.add(const LoadInitialDataEvent()),
        verify: (bloc) {
          expect(bloc.state.status.isFailure, isTrue);
          expect(bloc.state.errorMessage, equals('Invalid data received from server. Please try again.'));
        },
      );
    });

    group('State convenience getters', () {
      test('isLoading returns correct value', () {
        final loadingState = SearchState.initial().copyWith(status: const Loading());
        expect(loadingState.isLoading, isTrue);
        
        final successState = SearchState.initial().copyWith(status: const Success(null));
        expect(successState.isLoading, isFalse);
      });

      test('hasError returns correct value', () {
        final errorState = SearchState.initial().copyWith(
            status: Failure('Error', Exception('test')),
        );
        expect(errorState.hasError, isTrue);
        
        final successState = SearchState.initial().copyWith(status: const Success(null));
        expect(successState.hasError, isFalse);
      });

      test('hasInitialData returns correct value', () {
        final stateWithData = SearchState.initial().copyWith(
          initialData: InitialData(
            areas: testAreas,
            compounds: testCompounds,
            filterOptions: testFilterOptions,
          ),
        );
        expect(stateWithData.hasInitialData, isTrue);
        
        final stateWithoutData = SearchState.initial();
        expect(stateWithoutData.hasInitialData, isFalse);
      });

      test('hasSearchResults returns correct value', () {
        final stateWithResults = SearchState.initial().copyWith(searchResults: testSearchResponse);
        expect(stateWithResults.hasSearchResults, isTrue);
        
        final stateWithoutResults = SearchState.initial();
        expect(stateWithoutResults.hasSearchResults, isFalse);
      });

      test('hasFiltersApplied returns correct value', () {
        final stateWithFilters = SearchState.initial().copyWith(currentFilters: testFilters);
        expect(stateWithFilters.hasFiltersApplied, isTrue);
        
        final stateWithoutFilters = SearchState.initial();
        expect(stateWithoutFilters.hasFiltersApplied, isFalse);
      });

      test('errorMessage returns correct value', () {
        const errorMessage = 'Test error message';
        final errorState = SearchState.initial().copyWith(
            status: Failure(errorMessage, Exception('test')),
        );
        expect(errorState.errorMessage, equals(errorMessage));
        
        final successState = SearchState.initial().copyWith(status: const Success(null));
        expect(successState.errorMessage, isNull);
      });
    });
  });
}
