import 'package:equatable/equatable.dart';

/// Domain entity for Developer - pure business logic model
class Developer extends Equatable {
  final int id;
  final String name;
  final String? slug;
  final String? logoPath;

  const Developer({required this.id, required this.name, this.slug, this.logoPath});

  @override
  List<Object?> get props => [id, name, slug, logoPath];

  @override
  String toString() => 'Developer(id: $id, name: $name)';
}
