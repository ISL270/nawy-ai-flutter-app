import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_ai_app/app/features/favorites/presentation/bloc/favorites_bloc_exports.dart';
import 'package:nawy_ai_app/app/features/property_search/presentation/widgets/property_card.dart';

/// Favourites page - Saved properties and compounds
class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavouritesPageContent();
  }
}

class _FavouritesPageContent extends StatelessWidget {
  const _FavouritesPageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status.isFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading favourites',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage ?? 'Something went wrong',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FavoritesBloc>().add(const LoadFavoritesEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final favoriteProperties = state.favoriteProperties;

            if (favoriteProperties.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No Favourites Yet',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start exploring properties and save your favorites here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Header section matching explore page style
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        'Your Favourites',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${favoriteProperties.length} ${favoriteProperties.length == 1 ? 'property' : 'properties'}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Property list matching explore page layout
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<FavoritesBloc>().add(const LoadFavoritesEvent());
                    },
                    child: ListView.builder(
                      itemCount: favoriteProperties.length,
                      itemBuilder: (context, index) {
                        final property = favoriteProperties[index];
                        return BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, favoritesState) {
                            // Update property with current favorite status
                            final updatedProperty = property.copyWith(
                              isFavorite: favoritesState.isPropertyFavorite(property.id),
                            );
                            
                            return PropertyCard(
                              property: updatedProperty,
                              onFavoriteToggle: () {
                                context.read<FavoritesBloc>().add(
                                  TogglePropertyFavoriteEvent(property),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
