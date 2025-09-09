import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_app/app/features/search/domain/models/area.dart';
import 'package:nawy_app/app/features/search/domain/models/compound.dart';
import 'package:nawy_app/app/features/search/domain/models/property_type.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';
import 'package:nawy_app/app/features/search/presentation/bloc/search_bloc_exports.dart';

/// Filter bottom sheet for property search
class FilterBottomSheet extends StatefulWidget {
  final SearchFilters currentFilters;
  final List<Area> areas;
  final List<Compound> compounds;
  final List<PropertyType> propertyTypes;
  final List<int> priceOptions;
  final List<int> bedroomOptions;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.areas,
    required this.compounds,
    required this.propertyTypes,
    required this.priceOptions,
    required this.bedroomOptions,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late SearchFilters _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.currentFilters;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          const FilterBottomSheetHeader(),
          
          // Filters content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Areas filter
                  AreasFilterSection(
                    areas: widget.areas,
                    selectedAreaIds: _filters.selectedAreaIds,
                    onSelectionChanged: (selectedIds) {
                      setState(() {
                        _filters = _filters.copyWith(selectedAreaIds: selectedIds);
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Compounds filter
                  CompoundsFilterSection(
                    compounds: widget.compounds,
                    selectedCompoundIds: _filters.selectedCompoundIds,
                    onSelectionChanged: (selectedIds) {
                      setState(() {
                        _filters = _filters.copyWith(selectedCompoundIds: selectedIds);
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Property types filter
                  PropertyTypesFilterSection(
                    propertyTypes: widget.propertyTypes,
                    selectedPropertyTypeIds: _filters.selectedPropertyTypeIds,
                    onSelectionChanged: (selectedIds) {
                      setState(() {
                        _filters = _filters.copyWith(selectedPropertyTypeIds: selectedIds);
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Price range filter
                  PriceRangeFilterSection(
                    priceOptions: widget.priceOptions,
                    minPrice: _filters.minPrice,
                    maxPrice: _filters.maxPrice,
                    onMinPriceChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(minPrice: value);
                      });
                    },
                    onMaxPriceChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(maxPrice: value);
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Bedrooms filter
                  BedroomsFilterSection(
                    bedroomOptions: widget.bedroomOptions,
                    minBedrooms: _filters.minBedrooms,
                    maxBedrooms: _filters.maxBedrooms,
                    onMinBedroomsChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(minBedrooms: value);
                      });
                    },
                    onMaxBedroomsChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(maxBedrooms: value);
                      });
                    },
                  ),
                  
                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),
          
          // Bottom buttons
          FilterBottomButtons(filters: _filters),
        ],
      ),
    );
  }
}

class FilterItem {
  final int id;
  final String name;
  final bool isSelected;

  const FilterItem({
    required this.id,
    required this.name,
    required this.isSelected,
  });
}

/// Filter bottom sheet header widget
class FilterBottomSheetHeader extends StatelessWidget {
  const FilterBottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Filter Properties',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

/// Areas filter section widget
class AreasFilterSection extends StatelessWidget {
  final List<Area> areas;
  final List<int> selectedAreaIds;
  final Function(List<int>) onSelectionChanged;

  const AreasFilterSection({
    super.key,
    required this.areas,
    required this.selectedAreaIds,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectFilterWidget(
      title: 'Areas',
      items: areas.map((area) => FilterItem(
        id: area.id,
        name: area.name,
        isSelected: selectedAreaIds.contains(area.id),
      )).toList(),
      onSelectionChanged: onSelectionChanged,
    );
  }
}

/// Compounds filter section widget
class CompoundsFilterSection extends StatelessWidget {
  final List<Compound> compounds;
  final List<int> selectedCompoundIds;
  final Function(List<int>) onSelectionChanged;

  const CompoundsFilterSection({
    super.key,
    required this.compounds,
    required this.selectedCompoundIds,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectFilterWidget(
      title: 'Compounds',
      items: compounds.map((compound) => FilterItem(
        id: compound.id,
        name: compound.name,
        isSelected: selectedCompoundIds.contains(compound.id),
      )).toList(),
      onSelectionChanged: onSelectionChanged,
    );
  }
}

/// Property types filter section widget
class PropertyTypesFilterSection extends StatelessWidget {
  final List<PropertyType> propertyTypes;
  final List<int> selectedPropertyTypeIds;
  final Function(List<int>) onSelectionChanged;

  const PropertyTypesFilterSection({
    super.key,
    required this.propertyTypes,
    required this.selectedPropertyTypeIds,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectFilterWidget(
      title: 'Property Types',
      items: propertyTypes.map((type) => FilterItem(
        id: type.id,
        name: type.name,
        isSelected: selectedPropertyTypeIds.contains(type.id),
      )).toList(),
      onSelectionChanged: onSelectionChanged,
    );
  }
}

/// Price range filter section widget
class PriceRangeFilterSection extends StatelessWidget {
  final List<int> priceOptions;
  final int? minPrice;
  final int? maxPrice;
  final Function(int?) onMinPriceChanged;
  final Function(int?) onMaxPriceChanged;

  const PriceRangeFilterSection({
    super.key,
    required this.priceOptions,
    required this.minPrice,
    required this.maxPrice,
    required this.onMinPriceChanged,
    required this.onMaxPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Range',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PriceDropdownWidget(
                label: 'Min Price',
                value: minPrice,
                priceOptions: priceOptions,
                onChanged: onMinPriceChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PriceDropdownWidget(
                label: 'Max Price',
                value: maxPrice,
                priceOptions: priceOptions,
                onChanged: onMaxPriceChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Bedrooms filter section widget
class BedroomsFilterSection extends StatelessWidget {
  final List<int> bedroomOptions;
  final int? minBedrooms;
  final int? maxBedrooms;
  final Function(int?) onMinBedroomsChanged;
  final Function(int?) onMaxBedroomsChanged;

  const BedroomsFilterSection({
    super.key,
    required this.bedroomOptions,
    required this.minBedrooms,
    required this.maxBedrooms,
    required this.onMinBedroomsChanged,
    required this.onMaxBedroomsChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bedrooms',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: BedroomDropdownWidget(
                label: 'Min Bedrooms',
                value: minBedrooms,
                bedroomOptions: bedroomOptions,
                onChanged: onMinBedroomsChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BedroomDropdownWidget(
                label: 'Max Bedrooms',
                value: maxBedrooms,
                bedroomOptions: bedroomOptions,
                onChanged: onMaxBedroomsChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Filter bottom buttons widget
class FilterBottomButtons extends StatelessWidget {
  final SearchFilters filters;

  const FilterBottomButtons({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<SearchBloc>().add(const ClearFiltersEvent());
                  Navigator.of(context).pop();
                },
                child: const Text('Clear All'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  context.read<SearchBloc>().add(UpdateFiltersEvent(filters));
                  context.read<SearchBloc>().add(SearchPropertiesEvent(filters));
                  Navigator.of(context).pop();
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Multi-select filter widget
class MultiSelectFilterWidget extends StatelessWidget {
  final String title;
  final List<FilterItem> items;
  final Function(List<int>) onSelectionChanged;

  const MultiSelectFilterWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => FilterChip(
            label: Text(item.name),
            selected: item.isSelected,
            onSelected: (selected) {
              final currentSelection = items
                  .where((i) => i.isSelected)
                  .map((i) => i.id)
                  .toList();
              
              if (selected) {
                currentSelection.add(item.id);
              } else {
                currentSelection.remove(item.id);
              }
              
              onSelectionChanged(currentSelection);
            },
            selectedColor: theme.colorScheme.primary.withOpacity(0.2),
            checkmarkColor: theme.colorScheme.primary,
          )).toList(),
        ),
      ],
    );
  }
}

/// Price dropdown widget
class PriceDropdownWidget extends StatelessWidget {
  final String label;
  final int? value;
  final List<int> priceOptions;
  final Function(int?) onChanged;

  const PriceDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.priceOptions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('Any'),
        ),
        ...priceOptions.map((price) => DropdownMenuItem<int?>(
          value: price,
          child: Text(_formatPrice(price.toDouble())),
        )),
      ],
      onChanged: onChanged,
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M EGP';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K EGP';
    } else {
      return '${price.toStringAsFixed(0)} EGP';
    }
  }
}

/// Bedroom dropdown widget
class BedroomDropdownWidget extends StatelessWidget {
  final String label;
  final int? value;
  final List<int> bedroomOptions;
  final Function(int?) onChanged;

  const BedroomDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.bedroomOptions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('Any'),
        ),
        ...bedroomOptions.map((bedrooms) => DropdownMenuItem<int?>(
          value: bedrooms,
          child: Text('$bedrooms BR'),
        )),
      ],
      onChanged: onChanged,
    );
  }
}
