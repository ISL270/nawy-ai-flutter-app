import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property_filters.dart';

abstract class PropertySearchEvent extends Equatable {
  const PropertySearchEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load initial data (areas, compounds, filter options)
class LoadInitialDataEvent extends PropertySearchEvent {
  const LoadInitialDataEvent();
}

/// Event to search properties with filters
class SearchPropertiesEvent extends PropertySearchEvent {
  final PropertyFilters filters;

  const SearchPropertiesEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}

/// Event to search properties with text query and filters
class SearchWithQueryEvent extends PropertySearchEvent {
  final String query;
  final PropertyFilters filters;

  const SearchWithQueryEvent(this.query, this.filters);

  @override
  List<Object?> get props => [query, filters];
}

/// Event to update search filters
class UpdateFiltersEvent extends PropertySearchEvent {
  final PropertyFilters filters;

  const UpdateFiltersEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}

/// Event to clear all filters
class ClearFiltersEvent extends PropertySearchEvent {
  const ClearFiltersEvent();
}

/// Event to reset search state
class ResetSearchEvent extends PropertySearchEvent {
  const ResetSearchEvent();
}
