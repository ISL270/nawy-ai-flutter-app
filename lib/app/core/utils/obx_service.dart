import 'package:nawy_app/app/features/favorites/data/sources/local/models/area_obx.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/compound_obx.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/developer_obx.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_obx.dart';
import 'package:nawy_app/app/features/favorites/data/sources/local/models/property_type_obx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../objectbox.g.dart'; // Generated ObjectBox code

class ObxService {
  late Store _store;
  Store get store => _store;

  // Box accessors for each entity
  late Box<PropertyObx> _propertyBox;
  late Box<CompoundObx> _compoundBox;
  late Box<AreaObx> _areaBox;
  late Box<DeveloperObx> _developerBox;
  late Box<PropertyTypeObx> _propertyTypeBox;

  Box<PropertyObx> get propertyBox => _propertyBox;
  Box<CompoundObx> get compoundBox => _compoundBox;
  Box<AreaObx> get areaBox => _areaBox;
  Box<DeveloperObx> get developerBox => _developerBox;
  Box<PropertyTypeObx> get propertyTypeBox => _propertyTypeBox;

  Future<void> initialize() async {
    final docsDir = await getApplicationDocumentsDirectory();
    
    // Create ObjectBox store with generated openStore function
    _store = await openStore(directory: p.join(docsDir.path, "nawy-objectbox"));
    
    // Initialize boxes for each entity
    _propertyBox = _store.box<PropertyObx>();
    _compoundBox = _store.box<CompoundObx>();
    _areaBox = _store.box<AreaObx>();
    _developerBox = _store.box<DeveloperObx>();
    _propertyTypeBox = _store.box<PropertyTypeObx>();
  }

  Future<void> close() async {
    _store.close();
  }
}
