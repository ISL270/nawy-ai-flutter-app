import 'package:nawy_app/app/features/search/domain/entities/compound.dart';
import 'package:nawy_app/app/features/search/domain/entities/property.dart';

abstract class FavoritesRepository {
  Future<List<Property>> getFavoriteProperties();
  Future<List<Compound>> getFavoriteCompounds();
  Future<void> addFavoriteProperty(Property property);
  Future<void> addFavoriteCompound(Compound compound);
  Future<void> removeFavoriteProperty(int propertyId);
  Future<void> removeFavoriteCompound(int compoundId);
  Future<bool> isPropertyFavorite(int propertyId);
  Future<bool> isCompoundFavorite(int compoundId);
}
