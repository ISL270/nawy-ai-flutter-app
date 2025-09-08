import 'package:isar/isar.dart';
import 'developer.dart';

part 'developer_isar.g.dart';

/// Persistence model for Developer - handles local storage with Isar
@Collection()
class DeveloperIsar {
  Id isarId = Isar.autoIncrement;
  
  late int id;
  late String name;
  String? slug;
  String? logoPath;

  DeveloperIsar();

  DeveloperIsar._({
    required this.id,
    required this.name,
    this.slug,
    this.logoPath,
  });

  /// Convert persistence model to domain entity
  Developer toEntity() {
    return Developer(
      id: id,
      name: name,
      slug: slug,
      logoPath: logoPath,
    );
  }

  /// Create persistence model from domain entity
  factory DeveloperIsar.fromEntity(Developer entity) {
    return DeveloperIsar._(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      logoPath: entity.logoPath,
    );
  }
}
