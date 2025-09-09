import 'package:equatable/equatable.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

/// Base class for all favorites events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all favorite properties and compounds
class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();
}

/// Event to toggle property favorite status
class TogglePropertyFavoriteEvent extends FavoritesEvent {
  final Property property;

  const TogglePropertyFavoriteEvent(this.property);

  @override
  List<Object?> get props => [property];
}

/// Event to toggle compound favorite status
class ToggleCompoundFavoriteEvent extends FavoritesEvent {
  final Compound compound;

  const ToggleCompoundFavoriteEvent(this.compound);

  @override
  List<Object?> get props => [compound];
}

/// Event to check if a property is favorite
class CheckPropertyFavoriteEvent extends FavoritesEvent {
  final int propertyId;

  const CheckPropertyFavoriteEvent(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

/// Event to check if a compound is favorite
class CheckCompoundFavoriteEvent extends FavoritesEvent {
  final int compoundId;

  const CheckCompoundFavoriteEvent(this.compoundId);

  @override
  List<Object?> get props => [compoundId];
}
