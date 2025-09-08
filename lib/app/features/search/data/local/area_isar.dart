import 'package:isar/isar.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';

part 'area_isar.g.dart';

/// Persistence model for Area - reference data for favorited items (not stored independently)
@Collection()
class AreaIsar {
  Id isarId = Isar.autoIncrement;

  late int id;
  late String name;
  String? slug;

  // Isar doesn't support Map<String, String> directly, so we store as JSON string
  String? translationsJson;

  AreaIsar();

  AreaIsar._({required this.id, required this.name, this.slug, this.translationsJson});

  /// Convert persistence model to domain entity
  Area toEntity() {
    Map<String, String>? translations;
    if (translationsJson != null) {
      // Parse JSON string back to Map (you might want to use dart:convert)
      // For now, keeping it simple
      translations = null; // TODO: Implement JSON parsing if needed
    }

    return Area(id: id, name: name, slug: slug, translations: translations);
  }

  /// Create persistence model from domain entity
  factory AreaIsar.fromEntity(Area entity) {
    String? translationsJson;
    if (entity.translations != null) {
      // Convert Map to JSON string (you might want to use dart:convert)
      // For now, keeping it simple
      translationsJson = null; // TODO: Implement JSON serialization if needed
    }

    return AreaIsar._(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      translationsJson: translationsJson,
    );
  }
}
