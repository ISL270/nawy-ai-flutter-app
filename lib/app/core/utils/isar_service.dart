import 'package:isar/isar.dart';
import 'package:nawy_app/app/features/search/data/local/area_isar.dart';
import 'package:nawy_app/app/features/search/data/local/compound_isar.dart';
import 'package:nawy_app/app/features/search/data/local/developer_isar.dart';
import 'package:nawy_app/app/features/search/data/local/property_isar.dart';
import 'package:nawy_app/app/features/search/data/local/property_type_isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {

  late Isar _isar;
  Isar get isar => _isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open([
      AreaIsarSchema,
      CompoundIsarSchema,
      PropertyIsarSchema,
      PropertyTypeIsarSchema,
      DeveloperIsarSchema,
    ], directory: dir.path);
  }

  Future<void> close() async {
    await _isar.close();
  }
}
