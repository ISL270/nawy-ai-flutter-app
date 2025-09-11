import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/area_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/compound_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/developer_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_hive.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_type_hive.dart';

class HiveService {
  // Box names
  static const String _propertyBoxName = 'properties';
  static const String _compoundBoxName = 'compounds';
  static const String _areaBoxName = 'areas';
  static const String _developerBoxName = 'developers';
  static const String _propertyTypeBoxName = 'property_types';

  // Box instances
  late Box<PropertyHive> _propertyBox;
  late Box<CompoundHive> _compoundBox;
  late Box<AreaHive> _areaBox;
  late Box<DeveloperHive> _developerBox;
  late Box<PropertyTypeHive> _propertyTypeBox;

  // Box getters
  Box<PropertyHive> get propertyBox => _propertyBox;
  Box<CompoundHive> get compoundBox => _compoundBox;
  Box<AreaHive> get areaBox => _areaBox;
  Box<DeveloperHive> get developerBox => _developerBox;
  Box<PropertyTypeHive> get propertyTypeBox => _propertyTypeBox;

  Future<void> initialize() async {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PropertyHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CompoundHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(AreaHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(DeveloperHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(PropertyTypeHiveAdapter());
    }

    // Open boxes
    _propertyBox = await Hive.openBox<PropertyHive>(_propertyBoxName);
    _compoundBox = await Hive.openBox<CompoundHive>(_compoundBoxName);
    _areaBox = await Hive.openBox<AreaHive>(_areaBoxName);
    _developerBox = await Hive.openBox<DeveloperHive>(_developerBoxName);
    _propertyTypeBox = await Hive.openBox<PropertyTypeHive>(_propertyTypeBoxName);
  }

  Future<void> close() async {
    await _propertyBox.close();
    await _compoundBox.close();
    await _areaBox.close();
    await _developerBox.close();
    await _propertyTypeBox.close();
  }

  /// Clear all data (useful for testing or data migration)
  Future<void> clearAll() async {
    await _propertyBox.clear();
    await _compoundBox.clear();
    await _areaBox.clear();
    await _developerBox.clear();
    await _propertyTypeBox.clear();
  }
}
