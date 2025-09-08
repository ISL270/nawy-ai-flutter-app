import 'package:equatable/equatable.dart';

/// Domain entity for Area - used in business logic
class Area extends Equatable {
  final int id;
  final String name;
  final String? slug;
  final Map<String, String>? translations;

  const Area({required this.id, required this.name, this.slug, this.translations});

  @override
  List<Object?> get props => [id, name, slug, translations];

  @override
  String toString() => 'Area(id: $id, name: $name)';
}
