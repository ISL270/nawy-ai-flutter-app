---
trigger: always_on
---

# Flutter rules

## Folder structure
lib/
├── main.dart              # Application entry point
├── app/
│   ├── core/             # Shared core functionality
│   │   ├── models/       # Base models
│   │   ├── utils/        # Utility functions
│   │   └── constants/    # App constants
│   ├── features/         # Application features
│   │   ├── feature_name/ # Each feature module
│   │   │   ├── data/    # Data layer (sources: local/remote)
│   │   │   ├── domain/  # Business logic (repositories/entities)
│   │   │   └── presentation/ # UI layer (bloc/pages/widgets)
│   └── widgets/         # Shared widgets

Key principles:
- Feature-first approach with isolated modules
- Clean Architecture within each feature
- Shared code in core/
- Common widgets in widgets/

## Packages
- **State management:** Prefer **BLoC**  
  - Clear separation of concerns  
  - Testable, predictable state transitions  
  - Strong ecosystem support  

- **Local persistence:** Prefer **Isar**  
  - High-performance, schema-based storage  
  - Well-suited for offline-first apps  
  - Strong Dart/Flutter integration  

- **Networking:** Prefer **Dio**  
  - Flexible request/response handling  
  - Built-in interceptors for logging, auth, retries  
  - Rich ecosystem of plugins  

- **Dependency injection:** Prefer **get_it** (with `injectable` for code-gen)  
  - Decoupled service management  
  - Test-friendly  
  - Scales well with feature-based architecture  

- **Testing:** Prefer **mocktail** and **bloc_test**  
  - Simplifies mocking  
  - Provides clear patterns for bloc-driven tests  

## Models
Each model should have three versions, with clear naming for separation of concerns:

- **Domain model (business logic)** → `User`  
  - Pure, framework-agnostic  
  - Contains only business-related fields and logic  

- **API model (JSON-serializable)** → `UserDto`  
  - Handles mapping from/to API responses  
  - Keeps external quirks (naming, types) away from domain  

- **Persistence model (Isar)** → `UserIsar`  
  - Annotated with `@collection`  
  - Optimized for local storage  

## UI
- Prefer creating separate widgets over helper methods, **default to creating new widgets** for:
  - Any component with internal state
  - Anything needing context-specific logic
  - Complex or reusable visual elements
- Reserve helper methods for **small, purely presentational, stateless code fragments** (e.g., small text spans, quick paddings).

## AI tooling: When to use the Dart & Flutter MCP server

Use the Dart & Flutter MCP server when you want your AI assistant to act with your project’s real context and official tooling, not just suggest code. It exposes tools over MCP (Model Context Protocol) so the assistant can inspect, run, and modify your Dart/Flutter project safely and repeatably.

- **Fix runtime/layout issues fast:** When you hit a RenderFlex overflow or other runtime/UI error, ask the assistant to inspect runtime errors, read the widget tree, and propose/apply a minimal fix. Keep/undo after review.

- **Code-aware troubleshooting:** When static analysis flags errors or you suspect missing imports/symbols, have the assistant resolve symbols, fetch docs/signatures, apply quick-fixes, and re-check analysis.

- **Package discovery and integration:** When adding a new capability (e.g., charts, auth, storage), use the assistant to search pub.dev, compare options, add the chosen package to pubspec, run pub get, and scaffold minimal usage code.

- **Test-driven iteration:** When changing behavior, let the assistant run tests, read failures, and propose targeted code changes until tests pass. Use this for red-green-refactor loops.

- **Dev-time app introspection:** When debugging behavior in a running app, ask to query runtime state, trigger hot reload, or fetch current errors directly through tooling rather than manual print-debugging.

- **Consistent formatting and hygiene:** When preparing a PR, ask the assistant to run formatter/analysis via the same config as dart format and the analysis server for consistent diffs.

- **Project-wide refactors (incremental):** For scoped, mechanical refactors (rename symbols, extract widgets, move files with import updates), let the assistant plan and apply steps using official tooling, then review the diff.

- **Onboarding and repo conventions:** For new contributors or fresh modules, have the assistant read the repo, surface conventions, and generate starter code aligned with analysis options and formatter settings.

### When not to use it
- **Large, risky rewrites:** Prefer manual design + smaller, reviewed MCP-driven steps instead of a single sweeping change.
- **Clients without Tools/Resources support:** If your MCP client cannot expose Tools/Resources, fall back to normal chat suggestions.