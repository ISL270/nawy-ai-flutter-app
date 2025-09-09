import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawy_app/app/core/injection/injection.dart';
import 'package:nawy_app/app/features/search/domain/property_repository.dart';
import 'package:nawy_app/app/features/search/presentation/bloc/search_bloc_exports.dart';
import 'package:nawy_app/app/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:nawy_app/app/features/search/presentation/widgets/property_list_view.dart';
import 'package:nawy_app/app/features/search/presentation/widgets/filter_bottom_sheet.dart';
import 'package:nawy_app/app/features/search/domain/models/search_filters.dart';

/// Explore page - Main property search and discovery page
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(getIt<PropertyRepository>())
        ..add(const LoadInitialDataEvent())
        ..add(const SearchPropertiesEvent(SearchFilters())),
      child: const _ExplorePageContent(),
    );
  }
}

class _ExplorePageContent extends StatelessWidget {
  const _ExplorePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
              // Search bar
              SearchBarWidget(
                hintText: 'Search properties...',
                searchQuery: state.searchQuery,
                onChanged: (query) => _updateSearchQuery(context, query),
                onFilterTap: () => _showFilterBottomSheet(context, state),
                hasActiveFilters: state.hasFiltersApplied,
                isLoading: state.isLoading,
              ),
              
              // Content based on state
              Expanded(
                child: _buildContent(context, state),
              ),
            ],
          );
        },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SearchState state) {
    // Show loading for initial data
    if (state.isLoading && !state.hasInitialData && !state.hasSearchResults) {
      return const InitialLoadingWidget();
    }

    // Show error if initial data failed to load
    if (state.hasError && !state.hasInitialData) {
      return InitialErrorWidget(
        errorMessage: state.errorMessage,
        onRetry: () {
          context.read<SearchBloc>().add(const LoadInitialDataEvent());
        },
      );
    }

    // Show search results if available
    if (state.hasSearchResults) {
      return PropertyListView(
        properties: state.searchResults!.properties.map((dto) => dto.toEntity()).toList(),
        isLoading: state.isLoading,
        errorMessage: state.hasError ? state.errorMessage : null,
        onRetry: () => _retrySearch(context, state),
        onPropertyTap: (property) => _onPropertyTap(context, property),
        onFavoriteToggle: (property) => _onFavoriteToggle(context, property),
      );
    }

    // Show loading state while waiting for initial search
    if (state.hasInitialData && state.isLoading) {
      return const SearchLoadingWidget();
    }

    // Fallback empty state (should rarely be reached)
    return const EmptyStateWidget();
  }




  void _updateSearchQuery(BuildContext context, String query) {
    final bloc = context.read<SearchBloc>();
    bloc.add(SearchWithQueryEvent(query, bloc.state.currentFilters));
  }

  void _showFilterBottomSheet(BuildContext context, SearchState state) {
    if (!state.hasInitialData) return;

    final initialData = state.initialData!;
    final searchBloc = context.read<SearchBloc>(); // Capture the bloc reference
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: searchBloc, // Use the captured reference
        child: FilterBottomSheet(
          currentFilters: state.currentFilters,
          areas: initialData.areas,
          compounds: initialData.compounds,
          propertyTypes: initialData.filterOptions.propertyTypes?.map((dto) => dto.toEntity()).toList() ?? [],
          priceOptions: _generatePriceOptions(initialData.filterOptions.minPriceList, initialData.filterOptions.maxPriceList),
          bedroomOptions: const [1, 2, 3, 4, 5, 6],
        ),
      ),
    );
  }


  void _retrySearch(BuildContext context, SearchState state) {
    final bloc = context.read<SearchBloc>();
    bloc.add(SearchPropertiesEvent(state.currentFilters));
  }

  void _onPropertyTap(BuildContext context, property) {
    // TODO: Navigate to property details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Property "${property.name}" tapped'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onFavoriteToggle(BuildContext context, property) {
    // TODO: Implement favorite toggle functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          property.isFavorite 
              ? 'Removed "${property.name}" from favorites'
              : 'Added "${property.name}" to favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<int> _generatePriceOptions(List<int> minPrices, List<int> maxPrices) {
    final Set<int> prices = {};
    prices.addAll(minPrices);
    prices.addAll(maxPrices);
    
    final sortedPrices = prices.toList()..sort();
    return sortedPrices;
  }
}

/// Initial loading widget for when the app is loading search options
class InitialLoadingWidget extends StatelessWidget {
  const InitialLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading search options...'),
        ],
      ),
    );
  }
}

/// Error widget for when initial data fails to load
class InitialErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const InitialErrorWidget({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

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
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load search options',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'Please check your internet connection',
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

/// Loading widget for when properties are being searched
class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({super.key});

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

/// Empty state widget for fallback cases
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No data available'),
    );
  }
}
