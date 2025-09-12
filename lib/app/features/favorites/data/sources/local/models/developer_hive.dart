import 'package:hive_ce/hive.dart';
import 'package:nawy_app/app/features/property_search/domain/models/developer.dart' as domain;

part 'developer_hive.g.dart';

/// Persistence model for Developer - handles local storage
@HiveType(typeId: 3)
class DeveloperHive extends HiveObject {
  @HiveField(0)
  late int developerId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? slug;

  @HiveField(3)
  String? logoPath;

  DeveloperHive();

  DeveloperHive._({
    required this.developerId,
    required this.name,
    this.slug,
    this.logoPath,
  });

  /// Convert persistence model to domain entity
  domain.Developer toEntity() {
    return domain.Developer(
      id: developerId,
      name: name,
      slug: slug,
      logoPath: logoPath,
    );
  }

  /// Create persistence model from domain entity
  factory DeveloperHive.fromEntity(domain.Developer entity) {
    return DeveloperHive._(
      developerId: entity.id,
      name: entity.name,
      slug: entity.slug,
      logoPath: entity.logoPath,
    );
  }
}
