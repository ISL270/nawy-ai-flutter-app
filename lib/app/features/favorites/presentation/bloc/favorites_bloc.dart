import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/core/utils/app_logger.dart';
import 'package:nawy_app/app/features/favorites/data/favorites_repository.dart';
import 'package:nawy_app/app/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:nawy_app/app/features/favorites/presentation/bloc/favorites_state.dart';

/// BLoC for managing favorites functionality
@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _repository;
  final AppLogger _logger;

  FavoritesBloc(this._repository, this._logger) : super(FavoritesState.initial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<TogglePropertyFavoriteEvent>(_onTogglePropertyFavorite);
    on<ToggleCompoundFavoriteEvent>(_onToggleCompoundFavorite);
    on<CheckPropertyFavoriteEvent>(_onCheckPropertyFavorite);
    on<CheckCompoundFavoriteEvent>(_onCheckCompoundFavorite);
  }

  /// Handle loading all favorites
  Future<void> _onLoadFavorites(LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    assert(() {
      _logger.debug('Loading favorites');
      return true;
    }());

    emit(state.copyWith(status: const Loading()));

    try {
      final properties = await _repository.getFavoriteProperties();
      final compounds = await _repository.getFavoriteCompounds();

      // Create sets of IDs for quick lookup
      final propertyIds = properties.map((p) => p.id).toSet();
      final compoundIds = compounds.map((c) => c.id).toSet();

      emit(state.copyWith(
        status: const Success(null),
        favoriteProperties: properties,
        favoriteCompounds: compounds,
        favoritePropertyIds: propertyIds,
        favoriteCompoundIds: compoundIds,
      ));

      assert(() {
        _logger.debug('Loaded ${properties.length} favorite properties and ${compounds.length} favorite compounds');
        return true;
      }());
    } catch (e) {
      assert(() {
        _logger.error('Error loading favorites: $e');
        return true;
      }());

      emit(state.copyWith(
        status: const Failure('Failed to load favorites. Please try again.'),
        errorMessage: 'Failed to load favorites. Please try again.',
      ));
    }
  }

  /// Handle toggling property favorite status
  Future<void> _onTogglePropertyFavorite(TogglePropertyFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final property = event.property;
    final isCurrentlyFavorite = state.isPropertyFavorite(property.id);

    assert(() {
      _logger.debug('Toggling property ${property.id} favorite status. Currently: $isCurrentlyFavorite');
      return true;
    }());

    try {
      if (isCurrentlyFavorite) {
        // Remove from favorites
        await _repository.removeFavoriteProperty(property.id);
        
        // Update state
        final updatedProperties = state.favoriteProperties.where((p) => p.id != property.id).toList();
        final updatedPropertyIds = Set<int>.from(state.favoritePropertyIds)..remove(property.id);
        
        emit(state.copyWith(
          favoriteProperties: updatedProperties,
          favoritePropertyIds: updatedPropertyIds,
        ));

        assert(() {
          _logger.debug('Removed property ${property.id} from favorites');
          return true;
        }());
      } else {
        // Add to favorites
        await _repository.addFavoriteProperty(property);
        
        // Update state
        final updatedProperties = [...state.favoriteProperties, property];
        final updatedPropertyIds = Set<int>.from(state.favoritePropertyIds)..add(property.id);
        
        emit(state.copyWith(
          favoriteProperties: updatedProperties,
          favoritePropertyIds: updatedPropertyIds,
        ));

        assert(() {
          _logger.debug('Added property ${property.id} to favorites');
          return true;
        }());
      }
    } catch (e) {
      assert(() {
        _logger.error('Error toggling property favorite: $e');
        return true;
      }());

      emit(state.copyWith(
        status: const Failure('Failed to update favorites. Please try again.'),
        errorMessage: 'Failed to update favorites. Please try again.',
      ));
    }
  }

  /// Handle toggling compound favorite status
  Future<void> _onToggleCompoundFavorite(ToggleCompoundFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final compound = event.compound;
    final isCurrentlyFavorite = state.isCompoundFavorite(compound.id);

    assert(() {
      _logger.debug('Toggling compound ${compound.id} favorite status. Currently: $isCurrentlyFavorite');
      return true;
    }());

    try {
      if (isCurrentlyFavorite) {
        // Remove from favorites
        await _repository.removeFavoriteCompound(compound.id);
        
        // Update state
        final updatedCompounds = state.favoriteCompounds.where((c) => c.id != compound.id).toList();
        final updatedCompoundIds = Set<int>.from(state.favoriteCompoundIds)..remove(compound.id);
        
        emit(state.copyWith(
          favoriteCompounds: updatedCompounds,
          favoriteCompoundIds: updatedCompoundIds,
        ));

        assert(() {
          _logger.debug('Removed compound ${compound.id} from favorites');
          return true;
        }());
      } else {
        // Add to favorites
        await _repository.addFavoriteCompound(compound);
        
        // Update state
        final updatedCompounds = [...state.favoriteCompounds, compound];
        final updatedCompoundIds = Set<int>.from(state.favoriteCompoundIds)..add(compound.id);
        
        emit(state.copyWith(
          favoriteCompounds: updatedCompounds,
          favoriteCompoundIds: updatedCompoundIds,
        ));

        assert(() {
          _logger.debug('Added compound ${compound.id} to favorites');
          return true;
        }());
      }
    } catch (e) {
      assert(() {
        _logger.error('Error toggling compound favorite: $e');
        return true;
      }());

      emit(state.copyWith(
        status: const Failure('Failed to update favorites. Please try again.'),
        errorMessage: 'Failed to update favorites. Please try again.',
      ));
    }
  }

  /// Handle checking if property is favorite
  Future<void> _onCheckPropertyFavorite(CheckPropertyFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      final isFavorite = await _repository.isPropertyFavorite(event.propertyId);
      
      if (isFavorite && !state.favoritePropertyIds.contains(event.propertyId)) {
        // Add to state if not already there
        final updatedPropertyIds = Set<int>.from(state.favoritePropertyIds)..add(event.propertyId);
        emit(state.copyWith(favoritePropertyIds: updatedPropertyIds));
      } else if (!isFavorite && state.favoritePropertyIds.contains(event.propertyId)) {
        // Remove from state if it shouldn't be there
        final updatedPropertyIds = Set<int>.from(state.favoritePropertyIds)..remove(event.propertyId);
        emit(state.copyWith(favoritePropertyIds: updatedPropertyIds));
      }
    } catch (e) {
      assert(() {
        _logger.error('Error checking property favorite status: $e');
        return true;
      }());
    }
  }

  /// Handle checking if compound is favorite
  Future<void> _onCheckCompoundFavorite(CheckCompoundFavoriteEvent event, Emitter<FavoritesState> emit) async {
    try {
      final isFavorite = await _repository.isCompoundFavorite(event.compoundId);
      
      if (isFavorite && !state.favoriteCompoundIds.contains(event.compoundId)) {
        // Add to state if not already there
        final updatedCompoundIds = Set<int>.from(state.favoriteCompoundIds)..add(event.compoundId);
        emit(state.copyWith(favoriteCompoundIds: updatedCompoundIds));
      } else if (!isFavorite && state.favoriteCompoundIds.contains(event.compoundId)) {
        // Remove from state if it shouldn't be there
        final updatedCompoundIds = Set<int>.from(state.favoriteCompoundIds)..remove(event.compoundId);
        emit(state.copyWith(favoriteCompoundIds: updatedCompoundIds));
      }
    } catch (e) {
      assert(() {
        _logger.error('Error checking compound favorite status: $e');
        return true;
      }());
    }
  }
}
