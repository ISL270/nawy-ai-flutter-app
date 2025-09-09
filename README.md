<div align="center">
  <table>
    <tr>
      <td>
        <img src="assets/nawy_logo.png" alt="Nawy Logo" width="150" height="150" style="object-fit: cover;">
      </td>
      <td>
        <div>
          <img src="https://img.shields.io/badge/Firebase%20AI-🤖-FF6B35.svg" alt="Firebase AI">
          <img src="https://img.shields.io/badge/Gemini%202.5%20Pro-🧠-4285F4.svg" alt="Gemini 2.5 Pro">
          <img src="https://img.shields.io/badge/Tool%20Calling-🔧-34A853.svg" alt="Tool Calling">
          <img src="https://img.shields.io/badge/Flutter%20Chat%20UI-💬-02569B.svg" alt="Flutter Chat UI">
          <br><br>
          <img src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" alt="Flutter">
          <img src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" alt="Dart">
          <img src="https://img.shields.io/badge/BLoC-FF6B35?logo=flutter&logoColor=white" alt="BLoC">
          <img src="https://img.shields.io/badge/ObjectBox-34A853?logo=objectbox&logoColor=white" alt="ObjectBox">
          <img src="https://img.shields.io/badge/Dio-02569B?logo=dart&logoColor=white" alt="Dio">
          <br><br>
          <img src="https://img.shields.io/badge/tests-187%20passing-brightgreen.svg" alt="Tests">
          <img src="https://img.shields.io/badge/coverage-100%25%20pass%20rate-brightgreen.svg" alt="Coverage">
          <img src="https://img.shields.io/badge/architecture-Clean%20Architecture-blue.svg" alt="Clean Architecture">
        </div>
      </td>
    </tr>
  </table>
</div>

# Nawy App - AI-Powered Real Estate Search

Revolutionary AI-powered real estate search app with conversational property discovery using Gemini 2.5 Pro and Clean Architecture.

## ✨ Features

- **🤖 AI Property Assistant**: Natural language search - "Find me a 3-bedroom villa in New Cairo under 5M EGP"
- **🔍 Smart Search**: Real-time text search across properties, areas, and compounds
- **⚡ Advanced Filtering**: Area, compound, price, bedrooms, and property type filters
- **❤️ Favorites**: Save properties locally for offline access
- **📱 Modern UI**: Clean, responsive interface following Flutter best practices

## 📱 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="assets/property_search.png" alt="Property Search" width="300">
        <br>
        <strong>Property Search & Results</strong>
      </td>
      <td align="center">
        <img src="assets/filters.png" alt="Advanced Filters" width="300">
        <br>
        <strong>Advanced Filtering Options</strong>
      </td>
    </tr>
  </table>
</div>

## 🏗️ Architecture

**Clean Architecture** with feature-first structure:
- **Data Layer**: API sources, DTOs, ObjectBox entities
- **Domain Layer**: Business logic, repositories, entities  
- **Presentation Layer**: BLoC state management, pages, widgets

**Tech Stack:**
- Flutter + Dart
- BLoC for state management
- ObjectBox for local storage
- Dio for networking
- get_it + injectable for DI

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart
├── app/
│   ├── core/              # Shared utilities, constants
│   ├── features/          # Feature modules
│   │   ├── search/        # Property search
│   │   ├── favorites/     # Favorites management
│   │   └── ai_chat/       # AI assistant
│   └── widgets/           # Shared widgets
```

## 🧪 Testing

**187 tests** with **100% pass rate**:

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

**Test Coverage:**
- Unit tests (Core utilities)
- DTO serialization tests
- BLoC business logic tests
- API integration tests
- Live endpoint validation

## 🤖 AI Assistant

Powered by **Firebase AI Logic** and **Gemini 2.5 Pro**:

- Natural language property queries
- Contextual understanding and memory
- Tool calling for precise database interactions
- Conversational interface with flutter_chat_ui

**Example queries:**
- "Show me luxury apartments in Bloomfields"
- "Find villas under 4M EGP with 4+ bedrooms"
- "What's available in New Cairo?"

## 📊 Data Strategy

- **Online-first**: Live property data via API
- **Favorites-only local storage**: ObjectBox for saved properties
- **Client-side filtering**: Comprehensive search and filter logic
- **Production-ready**: Easy API restoration when endpoints become functional

## ⚠️ API Note

Current API endpoints serve static data, so we implemented:
- Local `properties.json` with 100+ realistic properties
- Client-side filtering logic
- Preserved network code for future API integration

## 🔧 Development

**Key Commands:**
```bash
# Code generation
dart run build_runner build

# Run tests
flutter test

# Format code
dart format .

# Analyze code
flutter analyze
```

---

Built with ❤️ using Flutter and Clean Architecture principles.
