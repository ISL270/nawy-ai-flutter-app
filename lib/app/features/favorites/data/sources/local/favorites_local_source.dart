import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/utils/hive_service.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/compound_hive.dart';
import 'package:nawy_app/app/features/property_search/domain/models/property.dart';
import 'package:nawy_app/app/features/property_search/domain/models/compound.dart';

/// Local data source for favorites using Hive
@injectable
class FavoritesLocalSource {
  final HiveService _hiveService;

  FavoritesLocalSource(this._hiveService);

  /// Get all favorite properties
  Future<List<Property>> getFavoriteProperties() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.propertyBox;
        final propertyHiveList = box.values.toList();
        return propertyHiveList.map((hive) => hive.toEntity()).toList();
      },
      const Duration(seconds: 5),
      'GetFavoriteProperties',
    );
  }

  /// Get all favorite compounds
  Future<List<Compound>> getFavoriteCompounds() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.compoundBox;
        final compoundHiveList = box.values.toList();
        return compoundHiveList.map((hive) => hive.toEntity()).toList();
      },
      const Duration(seconds: 5),
      'GetFavoriteCompounds',
    );
  }

  /// Add property to favorites
  Future<void> addFavoriteProperty(Property property) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.propertyBox;
        
        // Check if already exists using propertyId as key
        final key = 'property_${property.id}';
        if (box.containsKey(key)) {
          return; // Already exists
        }
        
        // Create new favorite property with isFavorite = true
        final favoriteProperty = property.copyWith(isFavorite: true);
        final propertyHive = PropertyHive.fromEntity(favoriteProperty);
        await box.put(key, propertyHive);
      },
      const Duration(seconds: 5),
      'AddFavoriteProperty',
    );
  }

  /// Add compound to favorites
  Future<void> addFavoriteCompound(Compound compound) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.compoundBox;
        
        // Check if already exists using compoundId as key
        final key = 'compound_${compound.id}';
        if (box.containsKey(key)) {
          return; // Already exists
        }
        
        final compoundHive = CompoundHive.fromEntity(compound);
        await box.put(key, compoundHive);
      },
      const Duration(seconds: 5),
      'AddFavoriteCompound',
    );
  }

  /// Remove property from favorites
  Future<void> removeFavoriteProperty(int propertyId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.propertyBox;
        final key = 'property_$propertyId';
        await box.delete(key);
      },
      const Duration(seconds: 5),
      'RemoveFavoriteProperty',
    );
  }

  /// Remove compound from favorites
  Future<void> removeFavoriteCompound(int compoundId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.compoundBox;
        final key = 'compound_$compoundId';
        await box.delete(key);
      },
      const Duration(seconds: 5),
      'RemoveFavoriteCompound',
    );
  }

  /// Check if property is favorite
  Future<bool> isPropertyFavorite(int propertyId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.propertyBox;
        final key = 'property_$propertyId';
        return box.containsKey(key);
      },
      const Duration(seconds: 5),
      'IsPropertyFavorite',
    );
  }

  /// Check if compound is favorite
  Future<bool> isCompoundFavorite(int compoundId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _hiveService.compoundBox;
        final key = 'compound_$compoundId';
        return box.containsKey(key);
      },
      const Duration(seconds: 5),
      'IsCompoundFavorite',
    );
  }
}
