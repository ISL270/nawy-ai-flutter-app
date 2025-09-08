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
- **State Management**: Uses **BLoC pattern** for predictable state management
- **Local Storage**: **Isar** database for favorites only (properties and compounds)
- **Networking**: **Dio** for HTTP requests with interceptors
- **Dependency Injection**: **get_it** with **injectable** for code generation

## Tech Stack

- **Framework**: Flutter with Dart
- **State Management**: flutter_bloc
- **Local Database**: Isar (for favorites only)
- **Networking**: Dio with interceptors
- **Serialization**: json_annotation + build_runner
- **Dependency Injection**: get_it + injectable (code generation)

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── app/
│   ├── core/             # Shared core functionality
│   │   ├── models/       # Domain entities, DTOs, and Isar models
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
- **Isar** (e.g., `PropertyIsar`) - Local database persistence (favorites only)

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

## Data Strategy

- **Online-first**: All property search and browsing requires internet connection
- **Selective Local Storage**: Only favorited items are persisted locally using Isar
- **Favorites Access**: Users can view their saved properties/compounds offline in the favorites tab
