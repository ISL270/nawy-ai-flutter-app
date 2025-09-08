import 'package:objectbox/objectbox.dart';
import 'package:nawy_app/app/features/search/domain/models/developer.dart';

/// Persistence model for Developer - reference data for favorited items (not stored independently)
@Entity()
class DeveloperObx {
  @Id()
  int id = 0;

  late int developerId;
  late String name;
  String? slug;
  String? logoPath;

  DeveloperObx();

  DeveloperObx._({
    required this.developerId,
    required this.name,
    this.slug,
    this.logoPath,
  });

  /// Convert persistence model to domain entity
  Developer toEntity() {
    return Developer(id: developerId, name: name, slug: slug, logoPath: logoPath);
  }

  /// Create persistence model from domain entity
  factory DeveloperObx.fromEntity(Developer entity) {
    return DeveloperObx._(
      developerId: entity.id,
      name: entity.name,
      slug: entity.slug,
      logoPath: entity.logoPath,
    );
  }
}
