import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/filter_options.dart';
import 'package:nawy_app/app/features/search/data/sources/remote/models/search_response.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';

final class SearchState extends Equatable {
  // Overall loading/error status
  final VoidStatus status;

  // Current search filters
  final SearchFilters currentFilters;

  // Current search query
  final String? searchQuery;

  // Initial data (areas, compounds, filter options)
  final InitialData? initialData;

  // Search results
  final SearchResponse? searchResults;

  const SearchState._({
    required this.status,
    required this.currentFilters,
    this.searchQuery,
    required this.initialData,
    required this.searchResults,
  });

  // Factory constructor for initial state
  const SearchState._initial()
    : this._(
        status: const Initial(),
        currentFilters: const SearchFilters(),
        searchQuery: null,
        initialData: null,
        searchResults: null,
      );

  // Factory constructor - use this instead of default constructor
  factory SearchState.initial() => SearchState._initial();

  SearchState _copyWith({
    VoidStatus? status,
    SearchFilters? currentFilters,
    String? searchQuery,
    InitialData? initialData,
    SearchResponse? searchResults,
    bool clearSearchResults = false,
  }) {
    return SearchState._(
      status: status ?? this.status,
      currentFilters: currentFilters ?? this.currentFilters,
      searchQuery: searchQuery ?? this.searchQuery,
      initialData: initialData ?? this.initialData,
      searchResults: clearSearchResults ? null : (searchResults ?? this.searchResults),
    );
  }

  // Public copyWith method
  SearchState copyWith({
    VoidStatus? status,
    SearchFilters? currentFilters,
    String? searchQuery,
    InitialData? initialData,
    SearchResponse? searchResults,
    bool clearSearchResults = false,
  }) {
    return _copyWith(
      status: status,
      currentFilters: currentFilters,
      searchQuery: searchQuery,
      initialData: initialData,
      searchResults: searchResults,
      clearSearchResults: clearSearchResults,
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
