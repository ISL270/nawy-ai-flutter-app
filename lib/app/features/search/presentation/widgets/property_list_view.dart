import 'package:flutter/material.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';
import 'package:nawy_app/app/features/search/presentation/widgets/property_card.dart';

/// Property list view widget for displaying search results
class PropertyListView extends StatelessWidget {
  final List<Property> properties;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final Function(Property)? onPropertyTap;
  final Function(Property)? onFavoriteToggle;
  final ScrollController? scrollController;

  const PropertyListView({
    super.key,
    required this.properties,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.onPropertyTap,
    this.onFavoriteToggle,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && properties.isEmpty) {
      return const PropertyLoadingState();
    }

    if (errorMessage != null && properties.isEmpty) {
      return PropertyErrorState(errorMessage: errorMessage, onRetry: onRetry);
    }

    if (properties.isEmpty) {
      return const PropertyEmptyState();
    }

    return PropertyList(
      properties: properties,
      isLoading: isLoading,
      onPropertyTap: onPropertyTap,
      onFavoriteToggle: onFavoriteToggle,
      scrollController: scrollController,
    );
  }
}

/// Loading state widget for property list
class PropertyLoadingState extends StatelessWidget {
  const PropertyLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading properties...'),
        ],
      ),
    );
  }
}

/// Error state widget for property list
class PropertyErrorState extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;

  const PropertyErrorState({super.key, this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'Failed to load properties',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state widget for property list
class PropertyEmptyState extends StatelessWidget {
  const PropertyEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No properties found',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search filters to find more properties',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Property list widget with results header
class PropertyList extends StatelessWidget {
  final List<Property> properties;
  final bool isLoading;
  final Function(Property)? onPropertyTap;
  final Function(Property)? onFavoriteToggle;
  final ScrollController? scrollController;

  const PropertyList({
    super.key,
    required this.properties,
    this.isLoading = false,
    this.onPropertyTap,
    this.onFavoriteToggle,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Results header
        PropertyResultsHeader(propertyCount: properties.length, isLoading: isLoading),

        // Property list
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: properties.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == properties.length) {
                // Loading indicator at the bottom
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final property = properties[index];
              return PropertyCard(
                property: property,
                onTap: () => onPropertyTap?.call(property),
                onFavoriteToggle: () => onFavoriteToggle?.call(property),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Results header widget for property list
class PropertyResultsHeader extends StatelessWidget {
  final int propertyCount;
  final bool isLoading;

  const PropertyResultsHeader({super.key, required this.propertyCount, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(bottom: BorderSide(color: theme.colorScheme.outline.withOpacity(0.2))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$propertyCount ${propertyCount == 1 ? 'property' : 'properties'} found',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
            ],
          ),
          // Demo API limitation notice
          if (propertyCount == 12) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Demo API limitation: Always returns the same 12 properties regardless of search filters. This is a server-side limitation, not an app issue.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
