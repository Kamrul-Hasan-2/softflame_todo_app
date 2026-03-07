# Free Health Camp - Flutter App

A Flutter application built with Clean Architecture and Riverpod state management.

## 🏗️ Architecture

This project follows **Clean Architecture** with:
- **Presentation Layer** - UI and state management (Riverpod)
- **Domain Layer** - Business logic and use cases
- **Data Layer** - Data sources and repository implementations
- **Core Layer** - Shared utilities and constants

## 📦 Key Technologies

- Flutter & Dart
- Riverpod (State Management)
- Clean Architecture
- Dartz (Functional Programming)
- SharedPreferences (Local Storage)

## 📁 Project Structure

```
lib/
├── core/              # Shared utilities, themes, constants
├── features/          # Feature modules
│   └── auth/          # Authentication feature
│       ├── data/      # Data layer
│       ├── domain/    # Business logic
│       └── presentation/  # UI and state
└── main.dart
```



