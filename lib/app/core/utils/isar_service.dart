import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/area/area_isar.dart';
import '../models/compound/compound_isar.dart';
import '../models/property/property_isar.dart';
import '../models/property_type/property_type_isar.dart';
import '../models/developer/developer_isar.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  late Isar _isar;
  Isar get isar => _isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        AreaIsarSchema,
        CompoundIsarSchema,
        PropertyIsarSchema,
        PropertyTypeIsarSchema,
        DeveloperIsarSchema,
      ],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await _isar.close();
  }
}
