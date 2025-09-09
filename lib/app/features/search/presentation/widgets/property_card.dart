import 'package:flutter/material.dart';
import 'package:nawy_app/app/features/search/domain/models/property.dart';

/// Property card widget for displaying property information in search results
class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const PropertyCard({super.key, required this.property, this.onTap, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property image
            PropertyImage(property: property),

            // Property details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property name and favorite button
                  PropertyHeader(
                    property: property,
                    onFavoriteToggle: onFavoriteToggle,
                  ),

                  const SizedBox(height: 8),

                  // Location info
                  if (property.area != null || property.compound != null)
                    PropertyLocationInfo(property: property),

                  const SizedBox(height: 8),

                  // Property details row
                  PropertyDetails(property: property),

                  const SizedBox(height: 12),

                  // Price and badges
                  PropertyPriceAndBadges(property: property),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Property image widget with placeholder support
class PropertyImage extends StatelessWidget {
  final Property property;

  const PropertyImage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: property.image != null
          ? ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                property.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const PropertyImagePlaceholder(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const PropertyImagePlaceholder();
                },
              ),
            )
          : const PropertyImagePlaceholder(),
    );
  }
}

/// Placeholder widget for property images
class PropertyImagePlaceholder extends StatelessWidget {
  const PropertyImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'No Image',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Property header with name and favorite button
class PropertyHeader extends StatelessWidget {
  final Property property;
  final VoidCallback? onFavoriteToggle;

  const PropertyHeader({
    super.key,
    required this.property,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            property.name,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: onFavoriteToggle,
          icon: Icon(
            property.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: property.isFavorite
                ? Colors.red
                : theme.colorScheme.onSurfaceVariant,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

/// Property location information widget
class PropertyLocationInfo extends StatelessWidget {
  final Property property;

  const PropertyLocationInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locationParts = <String>[];

    if (property.area != null) {
      locationParts.add(property.area!.name);
    }
    if (property.compound != null) {
      locationParts.add(property.compound!.name);
    }

    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            locationParts.join(' • '),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Property details chips (bedrooms, bathrooms, area)
class PropertyDetails extends StatelessWidget {
  final Property property;

  const PropertyDetails({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final details = <Widget>[];

    // Bedrooms
    if (property.numberOfBedrooms != null && property.numberOfBedrooms! > 0) {
      details.add(PropertyDetailChip(
        icon: Icons.bed,
        label: '${property.numberOfBedrooms} ${property.numberOfBedrooms == 1 ? 'Bedroom' : 'Bedrooms'}',
      ));
    }

    // Bathrooms
    if (property.numberOfBathrooms != null && property.numberOfBathrooms! > 0) {
      details.add(PropertyDetailChip(
        icon: Icons.bathtub,
        label: '${property.numberOfBathrooms} ${property.numberOfBathrooms == 1 ? 'Bathroom' : 'Bathrooms'}',
      ));
    }

    // Area
    if (property.minUnitArea != null || property.maxUnitArea != null) {
      String areaText;
      if (property.minUnitArea != null && property.maxUnitArea != null) {
        if (property.minUnitArea == property.maxUnitArea) {
          areaText = '${property.minUnitArea!.toInt()} m²';
        } else {
          areaText = '${property.minUnitArea!.toInt()}-${property.maxUnitArea!.toInt()} m²';
        }
      } else if (property.minUnitArea != null) {
        areaText = '${property.minUnitArea!.toInt()} m²';
      } else {
        areaText = '${property.maxUnitArea!.toInt()} m²';
      }

      details.add(PropertyDetailChip(
        icon: Icons.square_foot,
        label: areaText,
      ));
    }

    return Wrap(spacing: 8, runSpacing: 4, children: details);
  }
}

/// Individual detail chip widget
class PropertyDetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const PropertyDetailChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Property price and badges widget
class PropertyPriceAndBadges extends StatelessWidget {
  final Property property;

  const PropertyPriceAndBadges({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PropertyPrice(
          price: property.minPrice?.round() ?? 0,
          currency: property.currency,
        ),
        PropertyBadges(property: property),
      ],
    );
  }
}

/// Property price information widget
class PropertyPrice extends StatelessWidget {
  final int price;
  final String? currency;

  const PropertyPrice({super.key, required this.price, this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (price <= 0) {
      return Text(
        'Price on request',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    String formattedPrice = _formatPrice(price.toDouble());
    String priceText = '$formattedPrice ${currency ?? 'EGP'}';

    return Text(
      priceText,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    } else {
      return price.toStringAsFixed(0);
    }
  }
}

/// Property badges widget
class PropertyBadges extends StatelessWidget {
  final Property property;

  const PropertyBadges({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badges = <Widget>[];

    if (property.newProperty) {
      badges.add(_buildBadge('NEW', theme.colorScheme.primary));
    }

    if (property.hasOffers) {
      badges.add(_buildBadge('OFFER', Colors.orange));
    }

    if (property.resale) {
      badges.add(_buildBadge('RESALE', theme.colorScheme.secondary));
    }

    return Row(
      children: badges.map((badge) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: badge,
      )).toList(),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
