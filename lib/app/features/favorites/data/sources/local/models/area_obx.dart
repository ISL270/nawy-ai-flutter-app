import 'dart:convert';
import 'package:objectbox/objectbox.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';

/// Persistence model for Area - reference data for favorited items (not stored independently)
@Entity()
class AreaObx {
  @Id()
  int id = 0;

  late int areaId;
  late String name;
  String? slug;

  // ObjectBox doesn't support Map<String, String> directly, so we store as JSON string
  String? translationsJson;

  AreaObx();

  AreaObx._({
    required this.areaId,
    required this.name,
    this.slug,
    this.translationsJson,
  });

  /// Convert persistence model to domain entity
  Area toEntity() {
    Map<String, String>? translations;
    if (translationsJson != null && translationsJson!.isNotEmpty) {
      try {
        final decoded = json.decode(translationsJson!) as Map<String, dynamic>;
        translations = decoded.map((key, value) => MapEntry(key, value.toString()));
      } catch (e) {
        // If JSON parsing fails, return null translations
        translations = null;
      }
    }

    return Area(id: areaId, name: name, slug: slug, translations: translations);
  }

  /// Create persistence model from domain entity
  factory AreaObx.fromEntity(Area entity) {
    String? translationsJson;
    if (entity.translations != null && entity.translations!.isNotEmpty) {
      try {
        translationsJson = json.encode(entity.translations);
      } catch (e) {
        // If JSON encoding fails, store null
        translationsJson = null;
      }
    }

    return AreaObx._(
      areaId: entity.id,
      name: entity.name,
      slug: entity.slug,
      translationsJson: translationsJson,
    );
  }
}
