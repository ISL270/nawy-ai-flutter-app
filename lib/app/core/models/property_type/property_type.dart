import 'package:equatable/equatable.dart';

/// Domain entity for PropertyType - pure business logic model
class PropertyType extends Equatable {
  final int id;
  final String name;
  final String? iconUrl;
  final bool hasLandArea;
  final bool hasMandatoryGardenArea;
  final int? manualRanking;

  const PropertyType({
    required this.id,
    required this.name,
    this.iconUrl,
    this.hasLandArea = false,
    this.hasMandatoryGardenArea = false,
    this.manualRanking,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        iconUrl,
        hasLandArea,
        hasMandatoryGardenArea,
        manualRanking,
      ];

  @override
  String toString() => 'PropertyType(id: $id, name: $name)';
}
