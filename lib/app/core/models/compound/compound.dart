import 'package:equatable/equatable.dart';
import '../area/area.dart';

/// Domain entity for Compound - used in business logic
class Compound extends Equatable {
  final int id;
  final int areaId;
  final String name;
  final String? slug;
  final String? imagePath;
  final int? developerId;
  final DateTime? updatedAt;
  final int? nawyOrganizationId;
  final bool hasOffers;
  final Area? area;
  final bool isFavorite;

  const Compound({
    required this.id,
    required this.areaId,
    required this.name,
    this.slug,
    this.imagePath,
    this.developerId,
    this.updatedAt,
    this.nawyOrganizationId,
    required this.hasOffers,
    this.area,
    this.isFavorite = false,
  });

  Compound copyWith({
    int? id,
    int? areaId,
    String? name,
    String? slug,
    String? imagePath,
    int? developerId,
    DateTime? updatedAt,
    int? nawyOrganizationId,
    bool? hasOffers,
    Area? area,
    bool? isFavorite,
  }) {
    return Compound(
      id: id ?? this.id,
      areaId: areaId ?? this.areaId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      imagePath: imagePath ?? this.imagePath,
      developerId: developerId ?? this.developerId,
      updatedAt: updatedAt ?? this.updatedAt,
      nawyOrganizationId: nawyOrganizationId ?? this.nawyOrganizationId,
      hasOffers: hasOffers ?? this.hasOffers,
      area: area ?? this.area,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        areaId,
        name,
        slug,
        imagePath,
        developerId,
        updatedAt,
        nawyOrganizationId,
        hasOffers,
        area,
        isFavorite,
      ];

  @override
  String toString() => 'Compound(id: $id, name: $name, isFavorite: $isFavorite)';
}
