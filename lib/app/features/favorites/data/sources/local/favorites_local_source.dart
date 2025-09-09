import 'package:injectable/injectable.dart';
import 'package:nawy_app/app/core/utils/obx_service.dart';
import 'package:nawy_app/app/core/utils/error_handler.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_obx.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/compound_obx.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';

/// Local data source for favorites using ObjectBox
@injectable
class FavoritesLocalSource {
  final ObxService _obxService;

  FavoritesLocalSource(this._obxService);

  /// Get all favorite properties
  Future<List<Property>> getFavoriteProperties() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<PropertyObx>();
        final propertyObxList = box.getAll();
        return propertyObxList.map((obx) => obx.toEntity()).toList();
      },
      const Duration(seconds: 5),
      'GetFavoriteProperties',
    );
  }

  /// Get all favorite compounds
  Future<List<Compound>> getFavoriteCompounds() async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<CompoundObx>();
        final compoundObxList = box.getAll();
        return compoundObxList.map((obx) => obx.toEntity()).toList();
      },
      const Duration(seconds: 5),
      'GetFavoriteCompounds',
    );
  }

  /// Add property to favorites
  Future<void> addFavoriteProperty(Property property) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<PropertyObx>();
        
        // Check if already exists
        final allProperties = box.getAll();
        final existing = allProperties.firstWhere(
          (p) => p.propertyId == property.id,
          orElse: () => PropertyObx(),
        );
        
        if (existing.id != 0) {
          return; // Already exists
        }
        
        // Create new favorite property with isFavorite = true
        final favoriteProperty = property.copyWith(isFavorite: true);
        final propertyObx = PropertyObx.fromEntity(favoriteProperty);
        box.put(propertyObx);
      },
      const Duration(seconds: 5),
      'AddFavoriteProperty',
    );
  }

  /// Add compound to favorites
  Future<void> addFavoriteCompound(Compound compound) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<CompoundObx>();
        
        // Check if already exists
        final allCompounds = box.getAll();
        final existing = allCompounds.firstWhere(
          (c) => c.compoundId == compound.id,
          orElse: () => CompoundObx(),
        );
        
        if (existing.id != 0) {
          return; // Already exists
        }
        
        final compoundObx = CompoundObx.fromEntity(compound);
        box.put(compoundObx);
      },
      const Duration(seconds: 5),
      'AddFavoriteCompound',
    );
  }

  /// Remove property from favorites
  Future<void> removeFavoriteProperty(int propertyId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<PropertyObx>();
        
        final allProperties = box.getAll();
        final existing = allProperties.firstWhere(
          (p) => p.propertyId == propertyId,
          orElse: () => PropertyObx(),
        );
        
        if (existing.id != 0) {
          box.remove(existing.id);
        }
      },
      const Duration(seconds: 5),
      'RemoveFavoriteProperty',
    );
  }

  /// Remove compound from favorites
  Future<void> removeFavoriteCompound(int compoundId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<CompoundObx>();
        
        final allCompounds = box.getAll();
        final existing = allCompounds.firstWhere(
          (c) => c.compoundId == compoundId,
          orElse: () => CompoundObx(),
        );
        
        if (existing.id != 0) {
          box.remove(existing.id);
        }
      },
      const Duration(seconds: 5),
      'RemoveFavoriteCompound',
    );
  }

  /// Check if property is favorite
  Future<bool> isPropertyFavorite(int propertyId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<PropertyObx>();
        final allProperties = box.getAll();
        return allProperties.any((p) => p.propertyId == propertyId);
      },
      const Duration(seconds: 5),
      'IsPropertyFavorite',
    );
  }

  /// Check if compound is favorite
  Future<bool> isCompoundFavorite(int compoundId) async {
    return await ErrorHandler.executeWithTimeout(
      () async {
        final box = _obxService.store.box<CompoundObx>();
        final allCompounds = box.getAll();
        return allCompounds.any((c) => c.compoundId == compoundId);
      },
      const Duration(seconds: 5),
      'IsCompoundFavorite',
    );
  }
}
