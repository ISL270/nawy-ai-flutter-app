# Nawy App

Real estate property search application built with Flutter. Features property search, filtering, and favorites functionality with Clean Architecture and BLoC pattern.

## Features

- **Text Search**: Search properties by name, area, or compound with real-time filtering
- **Advanced Filtering**: Filter by area, compound, price, bedrooms, property type
- **Favorites**: Save properties and compounds locally for offline access in favorites tab
- **Real-time Data**: API integration for live property data

## Architecture

This project follows **Clean Architecture** principles with a feature-first folder structure:

- **Clean Architecture**: Separated into data, domain, and presentation layers
- **Feature-first approach**: Each feature is isolated in its own module
- **State Management**: Uses **BLoC pattern** with improved state management architecture
- **Local Storage**: **ObjectBox** database for favorites only (properties and compounds)
- **Networking**: **Dio** for HTTP requests with interceptors
- **Dependency Injection**: **get_it** with **injectable** for code generation
- **Logging**: Professional logging framework with **AppLogger** service

## Tech Stack

- **Framework**: Flutter with Dart
- **State Management**: flutter_bloc + bloc_test
- **Local Database**: ObjectBox (for favorites only)
- **Networking**: Dio with interceptors
- **Serialization**: json_annotation + build_runner
- **Dependency Injection**: get_it + injectable (code generation)
- **Testing**: mocktail + bloc_test for comprehensive testing
- **Logging**: logger package with production-safe implementation

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── app/
│   ├── core/             # Shared core functionality
│   │   ├── models/       # Core models (Status<T>, shared types)
│   │   ├── utils/        # Utility functions
│   │   └── constants/    # App constants
│   ├── features/         # Application features
│   │   ├── search/       # Property search feature
│   │   ├── favorites/    # Favorites management
│   │   └── [feature]/    # Each feature module
│   │       ├── data/     # Data layer (sources: remote/local)
│   │       ├── domain/   # Business logic (repositories/entities)
│   │       └── presentation/ # UI layer (bloc/pages/widgets)
│   └── widgets/         # Shared widgets
```

## Model Architecture

Each entity follows a three-layer model pattern:
- **Domain Entity** (e.g., `Property`) - Pure business logic
- **DTO** (e.g., `PropertyDto`) - API serialization/deserialization  
- **ObjectBox** (e.g., `PropertyObx`) - Local database persistence (favorites only)

## Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Generate code:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Business Logic Implementation

### SearchBloc Architecture

The search feature uses an improved BLoC pattern with enhanced state management:

**SearchState Pattern (Hybrid Approach)**
- **Single Status**: Uses `VoidStatus status` instead of multiple status fields
- **Data Separation**: Direct data fields (`InitialData?`, `SearchResponse?`) instead of wrapping in Status objects
- **Private Constructor**: `SearchState._()` with factory `SearchState.initial()` prevents invalid states
- **Convenience Getters**: `isLoading`, `hasError`, `hasInitialData`, `hasSearchResults`, `errorMessage`

**SearchEvent Classes**
- `LoadInitialDataEvent` - Loads areas, compounds, filter options concurrently
- `SearchPropertiesEvent` - Searches properties with filters
- `SearchWithQueryEvent` - Searches properties with text query and filters (debounced)
- `UpdateFiltersEvent` - Updates filters without triggering search
- `ClearFiltersEvent` - Clears all applied filters
- `ResetSearchEvent` - Resets entire search state

**Key Features**
- **Constructor Injection**: Repository dependency injection (not added to DI container)
- **Concurrent Loading**: Uses `Future.wait()` for parallel initial data loading
- **Smart Parameter Handling**: Converts empty filter lists to `null` for API calls
- **Text Search Integration**: Debounced text search with 500ms delay to optimize performance
- **Comprehensive Error Handling**: Network, timeout, format exceptions with user-friendly messages

## Testing

This project maintains comprehensive test coverage with **187 tests** achieving **100% pass rate**.

### Test Architecture
- **Unit Tests**: Core utilities (DioClient, AppLogger, ObxService)
- **DTO Tests**: JSON serialization/deserialization for all models
- **Integration Tests**: API client integration with mocking
- **Repository Tests**: Domain layer business logic
- **BLoC Tests**: Business logic with bloc_test (17 tests)
- **API Contract Tests**: Live endpoint validation

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/core/utils/dio_client_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests with verbose output
flutter test --reporter=expanded
```

### Test Coverage Breakdown
- **Core Utils**: 58 tests (DioClient + AppLogger + ObxService)
- **DTO Models**: 60 tests (Property, Compound, FilterOptions, Area)
- **Remote Sources**: 13 tests (API integration + text search functionality)
- **Domain Layer**: 12 tests (Repository pattern)
- **BLoC Layer**: 17 tests (SearchBloc business logic with bloc_test)
- **API Contract**: 12 tests (Live endpoint validation)
- **Text Search**: Comprehensive testing of search functionality across property names, areas, and compounds

### BLoC Testing with bloc_test
```bash
# Run SearchBloc tests specifically
flutter test test/features/search/presentation/bloc/search_bloc_test.dart

# Test coverage includes:
# - Initial state validation
# - LoadInitialDataEvent: Success, network errors, socket exceptions
# - SearchPropertiesEvent: Success, timeout errors, empty filter handling  
# - Filter management: Update, clear, reset operations
# - State convenience getters validation
# - Error message mapping verification
```

## Text Search Implementation

The app features comprehensive text search functionality that allows users to find properties by typing search terms.

### Search Capabilities
- **Property Names**: Search within property titles (e.g., "Luxury Apartment", "Modern Villa")
- **Area Names**: Search by location names (e.g., "El Sheikh Zayed", "New Cairo")
- **Compound Names**: Search by development names (e.g., "ZED West", "Bloomfields")

### Search Features
- **Case-Insensitive**: "VILLA" and "villa" return identical results
- **Partial Matching**: "zayed" matches "El Sheikh Zayed"
- **Real-time Filtering**: Results update as you type with 500ms debounce
- **Combined Search**: Text search works alongside area, price, and bedroom filters
- **Smart Query Handling**: Empty/whitespace queries return all properties

### Technical Implementation
```dart
// Text search logic searches across multiple fields
if (searchQuery != null && searchQuery.trim().isNotEmpty) {
  final query = searchQuery.trim().toLowerCase();
  filteredProperties = filteredProperties.where((property) {
    final propertyName = property.name?.toLowerCase() ?? '';
    final areaName = property.area?.name?.toLowerCase() ?? '';
    final compoundName = property.compound?.name?.toLowerCase() ?? '';
    
    return propertyName.contains(query) || 
           areaName.contains(query) || 
           compoundName.contains(query);
  }).toList();
}
```

### Search Architecture
- **SearchBloc**: Handles `SearchWithQueryEvent` with debounced input processing
- **PropertyRepository**: Passes search queries to data sources
- **PropertyRemoteSource**: Implements client-side text filtering logic
- **SearchBarWidget**: Triggers search events on text input changes

## Data Strategy

- **Online-first**: All property search and browsing requires internet connection
- **No General Offline Support**: App requires internet for all search and browsing functionality
- **Favorites-Only Local Storage**: Only favorited properties and compounds are saved locally using ObjectBox
- **Offline Favorites Access**: Users can view their favorited items in the favorites tab without internet

## API Implementation Note

**Important**: The provided API endpoints don't function as expected for a proper search application, which required implementing a workaround:

### API Limitations Discovered
- **Properties Search**: Always returns the same 12 static properties regardless of any search filters
- **No Server-Side Filtering**: All query parameters (area_ids, compound_ids, price ranges, bedrooms, etc.) are completely ignored
- **Static JSON Files**: The API serves static JSON files instead of dynamic server responses
- **No Pagination**: No server-side pagination functionality is implemented

### Workaround Implementation
To demonstrate proper search and filtering functionality that would work with a real API, we implemented:

- **Local Data Source**: Created `properties.json` with 100 realistic properties matching the exact API response structure
- **Client-Side Filtering**: Implemented comprehensive search and filtering logic in `PropertyRemoteSource`
- **Preserved Network Code**: All original API integration code is preserved and commented out with detailed explanations
- **Production Ready**: The architecture is ready to switch back to network calls when a properly functioning API is available

### Files Modified for Workaround
- `lib/app/features/search/data/sources/remote/property_remote_source.dart` - Contains both commented network implementation and working local implementation
- `properties.json` - 100 properties in exact API format for demonstration
- All original network integration code is preserved and can be easily restored

This approach demonstrates both proper API integration patterns and functional search/filtering capabilities that would work with a real backend API.
