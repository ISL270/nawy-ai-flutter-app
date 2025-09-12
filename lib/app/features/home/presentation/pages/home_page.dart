import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:nawy_app/app/core/injection/injection.dart';
import 'package:nawy_app/app/features/favorites/data/favorites_repository.dart';
import 'package:nawy_app/app/features/favorites/presentation/bloc/favorites_bloc_exports.dart';

import '../../../ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../../../property_search/presentation/property_search_page.dart';
import 'favourites_page.dart';
import 'settings_page.dart';

/// Home page with bottom navigation bar
/// Contains four main sections: Explore, AI Assistant, Favourites, Settings
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PropertySearchPage(),
    const AiAssistantPage(),
    const FavouritesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesBloc(getIt<FavoritesRepository>(), getIt())..add(const LoadFavoritesEvent()),
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.grey.shade200,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          elevation: 8,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Symbols.wand_stars),
              selectedIcon: Icon(Symbols.wand_stars, fill: 1),
              label: 'AI Assistant',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
