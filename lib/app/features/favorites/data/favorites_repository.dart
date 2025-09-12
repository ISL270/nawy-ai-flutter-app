import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/favorites_local_source.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';

@singleton
class FavoritesRepository {
  final FavoritesLocalSource _localSource;

  FavoritesRepository(this._localSource);

  Future<List<Property>> getFavoriteProperties() async {
    return await _localSource.getFavoriteProperties();
  }

  Future<List<Compound>> getFavoriteCompounds() async {
    return await _localSource.getFavoriteCompounds();
  }

  Future<void> addFavoriteProperty(Property property) async {
    await _localSource.addFavoriteProperty(property);
  }

  Future<void> addFavoriteCompound(Compound compound) async {
    await _localSource.addFavoriteCompound(compound);
  }

  Future<void> removeFavoriteProperty(int propertyId) async {
    await _localSource.removeFavoriteProperty(propertyId);
  }

  Future<void> removeFavoriteCompound(int compoundId) async {
    await _localSource.removeFavoriteCompound(compoundId);
  }

  Future<bool> isPropertyFavorite(int propertyId) async {
    return await _localSource.isPropertyFavorite(propertyId);
  }

  Future<bool> isCompoundFavorite(int compoundId) async {
    return await _localSource.isCompoundFavorite(compoundId);
  }
}
