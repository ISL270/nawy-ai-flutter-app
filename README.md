# Nawy App

Real estate property search application built with Flutter. Features property search, filtering, and favorites functionality with Clean Architecture and BLoC pattern.

## Features

- **Property Search**: Advanced filtering by area, compound, price, bedrooms, property type
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
- `UpdateFiltersEvent` - Updates filters without triggering search
- `ClearFiltersEvent` - Clears all applied filters
- `ResetSearchEvent` - Resets entire search state

**Key Features**
- **Constructor Injection**: Repository dependency injection (not added to DI container)
- **Concurrent Loading**: Uses `Future.wait()` for parallel initial data loading
- **Smart Parameter Handling**: Converts empty filter lists to `null` for API calls
- **Comprehensive Error Handling**: Network, timeout, format exceptions with user-friendly messages

## Testing

This project maintains comprehensive test coverage with **174 tests** achieving **100% pass rate**.

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
- **Remote Sources**: 15 tests (API integration)
- **Domain Layer**: 12 tests (Repository pattern)
- **BLoC Layer**: 17 tests (SearchBloc business logic with bloc_test)
- **API Contract**: 12 tests (Live endpoint validation)

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

## Data Strategy

- **Online-first**: All property search and browsing requires internet connection
- **No General Offline Support**: App requires internet for all search and browsing functionality
- **Favorites-Only Local Storage**: Only favorited properties and compounds are saved locally using ObjectBox
- **Offline Favorites Access**: Users can view their favorited items in the favorites tab without internet
