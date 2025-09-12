import 'package:equatable/equatable.dart';

class PropertyFilters extends Equatable {
  final List<int> selectedAreaIds;
  final List<int> selectedCompoundIds;
  final int? minPrice;
  final int? maxPrice;
  final int? minBedrooms;
  final int? maxBedrooms;
  final List<int> selectedPropertyTypeIds;

  const PropertyFilters({
    this.selectedAreaIds = const [],
    this.selectedCompoundIds = const [],
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.maxBedrooms,
    this.selectedPropertyTypeIds = const [],
  });

  PropertyFilters copyWith({
    List<int>? selectedAreaIds,
    List<int>? selectedCompoundIds,
    int? minPrice,
    int? maxPrice,
    int? minBedrooms,
    int? maxBedrooms,
    List<int>? selectedPropertyTypeIds,
  }) {
    return PropertyFilters(
      selectedAreaIds: selectedAreaIds ?? this.selectedAreaIds,
      selectedCompoundIds: selectedCompoundIds ?? this.selectedCompoundIds,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      maxBedrooms: maxBedrooms ?? this.maxBedrooms,
      selectedPropertyTypeIds: selectedPropertyTypeIds ?? this.selectedPropertyTypeIds,
    );
  }

  bool get hasFilters =>
      selectedAreaIds.isNotEmpty ||
      selectedCompoundIds.isNotEmpty ||
      minPrice != null ||
      maxPrice != null ||
      minBedrooms != null ||
      maxBedrooms != null ||
      selectedPropertyTypeIds.isNotEmpty;

  @override
  List<Object?> get props => [
    selectedAreaIds,
    selectedCompoundIds,
    minPrice,
    maxPrice,
    minBedrooms,
    maxBedrooms,
    selectedPropertyTypeIds,
  ];
}
