import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load initial data (areas, compounds, filter options)
class LoadInitialDataEvent extends SearchEvent {
  const LoadInitialDataEvent();
}

/// Event to search properties with filters
class SearchPropertiesEvent extends SearchEvent {
  final SearchFilters filters;

  const SearchPropertiesEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}

/// Event to update search filters
class UpdateFiltersEvent extends SearchEvent {
  final SearchFilters filters;

  const UpdateFiltersEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}

/// Event to clear all filters
class ClearFiltersEvent extends SearchEvent {
  const ClearFiltersEvent();
}

/// Event to reset search state
class ResetSearchEvent extends SearchEvent {
  const ResetSearchEvent();
}
