import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';
import 'package:nawy_app/app/features/search/domain/property_repository.dart';
import 'package:nawy_app/app/features/search/presentation/bloc/search_event.dart';
import 'package:nawy_app/app/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PropertyRepository _repository;

  SearchBloc(this._repository) : super(SearchState.initial()) {
    on<LoadInitialDataEvent>(_onLoadInitialData);
    on<SearchPropertiesEvent>(_onSearchProperties);
    on<UpdateFiltersEvent>(_onUpdateFilters);
    on<ClearFiltersEvent>(_onClearFilters);
    on<ResetSearchEvent>(_onResetSearch);
  }

  /// Handles loading initial data (areas, compounds, filter options)
  Future<void> _onLoadInitialData(LoadInitialDataEvent event, Emitter<SearchState> emit) async {
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
    } catch (error) {
      final errorMessage = _getErrorMessage(error);
      emit(
        state.copyWith(
          status: Failure(errorMessage, error is Exception ? error : Exception(error.toString())),
        ),
      );
    }
  }

  /// Handles searching properties with current filters
  Future<void> _onSearchProperties(SearchPropertiesEvent event, Emitter<SearchState> emit) async {
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
    } catch (error) {
      final errorMessage = _getErrorMessage(error);
      emit(
        state.copyWith(
          status: Failure(errorMessage, error is Exception ? error : Exception(error.toString())),
        ),
      );
    }
  }

  /// Handles updating search filters without triggering search
  void _onUpdateFilters(UpdateFiltersEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(currentFilters: event.filters));
  }

  /// Handles clearing all filters
  void _onClearFilters(ClearFiltersEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(currentFilters: const SearchFilters()));
  }

  /// Handles resetting the entire search state
  void _onResetSearch(ResetSearchEvent event, Emitter<SearchState> emit) {
    emit(SearchState.initial());
  }

  /// Extracts user-friendly error messages from exceptions
  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return 'No internet connection. Please check your network and try again.';
    }

    if (error.toString().contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }

    if (error.toString().contains('FormatException')) {
      return 'Invalid data received from server. Please try again.';
    }

    // Generic error message for unknown errors
    return 'Something went wrong. Please try again.';
  }
}
