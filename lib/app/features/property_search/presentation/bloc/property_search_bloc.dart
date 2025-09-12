import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_app/app/core/models/bloc_event_transformers.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/property_search/domain/models/area.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property_filters.dart';
import 'package:nawy_app/app/features/property_search/domain/property_search_repository.dart';
import 'package:nawy_app/app/features/property_search/presentation/bloc/property_search_event.dart';
import 'package:nawy_app/app/features/property_search/presentation/bloc/property_search_state.dart';

class PropertySearchBloc extends Bloc<PropertySearchEvent, PropertySearchState> {
  final PropertySearchRepository _repository;

  PropertySearchBloc(this._repository) : super(PropertySearchState.initial()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<SearchPropertiesEvent>(_onSearchProperties);
    on<SearchWithQueryEvent>(
      _onSearchWithQuery,
      transformer: EventTransformers.debounce(const Duration(milliseconds: 500)),
    );
    on<UpdateFiltersEvent>(_onUpdateFilters);
    on<ClearFiltersEvent>(_onClearFilters);
    on<ResetSearchEvent>(_onResetSearch);
  }

  /// Handles loading initial data (areas, compounds, filter options)
  Future<void> _onLoadInitialData(
    LoadInitialDataEvent event,
    Emitter<PropertySearchState> emit,
  ) async {
    emit(state.copyWith(status: const Loading()));

    try {
      // Load all initial data concurrently for better performance
      final results = await Future.wait([
        _repository.getAreas(),
        _repository.getCompounds(),
        _repository.getFilterOptions(),
      ]);

      final areas = results[0] as List<Area>;
      final compounds = results[1] as List<Compound>;
      final filterOptions = results[2] as FilterOptions;

      final initialData = InitialData(
        areas: areas,
        compounds: compounds,
        filterOptions: filterOptions,
      );

      emit(state.copyWith(status: const Success(null), initialData: initialData));
    } on AppException catch (error) {
      emit(state.copyWith(status: Failure(error.message, error.originalException)));
    } catch (error) {
      emit(
        state.copyWith(
          status: Failure(
            'Something went wrong. Please try again.',
            error is Exception ? error : Exception(error.toString()),
          ),
        ),
      );
    }
  }

  /// Handles searching properties with current filters
  Future<void> _onSearchProperties(
    SearchPropertiesEvent event,
    Emitter<PropertySearchState> emit,
  ) async {
    emit(state.copyWith(status: const Loading(), currentFilters: event.filters));

    try {
      final searchResponse = await _repository.searchProperties(
        areaIds: event.filters.selectedAreaIds.isEmpty ? null : event.filters.selectedAreaIds,
        compoundIds: event.filters.selectedCompoundIds.isEmpty
            ? null
            : event.filters.selectedCompoundIds,
        minPrice: event.filters.minPrice,
        maxPrice: event.filters.maxPrice,
        minBedrooms: event.filters.minBedrooms,
        maxBedrooms: event.filters.maxBedrooms,
        propertyTypeIds: event.filters.selectedPropertyTypeIds.isEmpty
            ? null
            : event.filters.selectedPropertyTypeIds,
      );

      emit(state.copyWith(status: const Success(null), searchResults: searchResponse));
    } on AppException catch (error) {
      emit(state.copyWith(status: Failure(error.message, error.originalException)));
    } catch (error) {
      emit(
        state.copyWith(
          status: Failure(
            'Something went wrong. Please try again.',
            error is Exception ? error : Exception(error.toString()),
          ),
        ),
      );
    }
  }

  /// Handles searching properties with text query and filters
  Future<void> _onSearchWithQuery(
    SearchWithQueryEvent event,
    Emitter<PropertySearchState> emit,
  ) async {
    final isEmptyQuery = event.query.trim().isEmpty;

    emit(
      state.copyWith(
        status: const Loading(),
        currentFilters: event.filters,
        searchQuery: isEmptyQuery ? null : event.query,
        clearSearchQuery: isEmptyQuery,
      ),
    );

    try {
      final searchResponse = await _repository.searchProperties(
        searchQuery: event.query.trim().isEmpty ? null : event.query.trim(),
        areaIds: event.filters.selectedAreaIds.isEmpty ? null : event.filters.selectedAreaIds,
        compoundIds: event.filters.selectedCompoundIds.isEmpty
            ? null
            : event.filters.selectedCompoundIds,
        minPrice: event.filters.minPrice,
        maxPrice: event.filters.maxPrice,
        minBedrooms: event.filters.minBedrooms,
        maxBedrooms: event.filters.maxBedrooms,
        propertyTypeIds: event.filters.selectedPropertyTypeIds.isEmpty
            ? null
            : event.filters.selectedPropertyTypeIds,
      );

      emit(state.copyWith(status: const Success(null), searchResults: searchResponse));
    } on AppException catch (error) {
      emit(state.copyWith(status: Failure(error.message, error.originalException)));
    } catch (error) {
      emit(
        state.copyWith(
          status: Failure(
            'Something went wrong. Please try again.',
            error is Exception ? error : Exception(error.toString()),
          ),
        ),
      );
    }
  }

  /// Handles updating search filters without triggering search
  void _onUpdateFilters(UpdateFiltersEvent event, Emitter<PropertySearchState> emit) {
    emit(state.copyWith(currentFilters: event.filters));
  }

  /// Handles clearing all filters
  void _onClearFilters(ClearFiltersEvent event, Emitter<PropertySearchState> emit) {
    emit(state.copyWith(currentFilters: const PropertyFilters()));
  }

  /// Handles resetting the entire search state
  void _onResetSearch(ResetSearchEvent event, Emitter<PropertySearchState> emit) {
    emit(PropertySearchState.initial());
  }
}
