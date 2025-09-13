import 'package:equatable/equatable.dart';
import 'package:nawy_ai_app/app/core/models/status.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_ai_app/app/features/property_search/data/sources/remote/models/property_search_response.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/area.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/compound.dart';
import 'package:nawy_ai_app/app/features/property_search/domain/models/property_filters.dart';

final class PropertySearchState extends Equatable {
  // Overall loading/error status
  final VoidStatus status;

  // Current search filters
  final PropertyFilters currentFilters;

  // Current search query
  final String? searchQuery;

  // Initial data (areas, compounds, filter options)
  final InitialData? initialData;

  // Search results
  final PropertySearchResponse? searchResults;

  const PropertySearchState._({
    required this.status,
    required this.currentFilters,
    this.searchQuery,
    required this.initialData,
    required this.searchResults,
  });

  // Factory constructor for initial state
  const PropertySearchState._initial()
    : this._(
        status: const Initial(),
        currentFilters: const PropertyFilters(),
        searchQuery: null,
        initialData: null,
        searchResults: null,
      );

  // Factory constructor - use this instead of default constructor
  factory PropertySearchState.initial() => PropertySearchState._initial();

  PropertySearchState _copyWith({
    VoidStatus? status,
    PropertyFilters? currentFilters,
    String? searchQuery,
    InitialData? initialData,
    PropertySearchResponse? searchResults,
    bool clearSearchResults = false,
    bool clearSearchQuery = false,
  }) {
    return PropertySearchState._(
      status: status ?? this.status,
      currentFilters: currentFilters ?? this.currentFilters,
      searchQuery: clearSearchQuery ? null : (searchQuery ?? this.searchQuery),
      initialData: initialData ?? this.initialData,
      searchResults: clearSearchResults ? null : (searchResults ?? this.searchResults),
    );
  }

  // Public copyWith method
  PropertySearchState copyWith({
    VoidStatus? status,
    PropertyFilters? currentFilters,
    String? searchQuery,
    InitialData? initialData,
    PropertySearchResponse? searchResults,
    bool clearSearchResults = false,
    bool clearSearchQuery = false,
  }) {
    return _copyWith(
      status: status,
      currentFilters: currentFilters,
      searchQuery: searchQuery,
      initialData: initialData,
      searchResults: searchResults,
      clearSearchResults: clearSearchResults,
      clearSearchQuery: clearSearchQuery,
    );
  }

  // Convenience getters for checking states
  bool get isLoading => status.isLoading;
  bool get hasError => status.isFailure;
  bool get hasInitialData => initialData != null;
  bool get hasSearchResults => searchResults != null;
  bool get hasFiltersApplied => currentFilters.hasFilters;

  // Error message getter
  String? get errorMessage => status.isFailure ? (status as Failure).message : null;

  @override
  List<Object?> get props => [status, currentFilters, searchQuery, initialData, searchResults];
}

/// Container class for initial data needed for search functionality
class InitialData extends Equatable {
  final List<Area> areas;
  final List<Compound> compounds;
  final FilterOptions filterOptions;

  const InitialData({required this.areas, required this.compounds, required this.filterOptions});

  @override
  List<Object?> get props => [areas, compounds, filterOptions];
}
