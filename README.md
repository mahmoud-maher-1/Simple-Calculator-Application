# Calculator App Documentation

Welcome to the Calculator App! This document serves as a comprehensive guide for both users and developers.

---

## For Users: What is this App?
This is a simple, intuitive calculator designed for your mobile phone. It helps you perform everyday math calculations quickly and easily.

### What can it do?
*   **Add (+)**: Combine two numbers.
*   **Subtract (-)**: Find the difference between numbers.
*   **Multiply (x)**: Calculate the product of numbers.
*   **Divide (÷)**: Split a number into equal parts.

### How to use it?
1.  **Tap the numbers** (0-9) to enter them on the screen.
2.  **Tap an operation** (+, -, x, ÷) to choose what you want to do.
3.  **Tap Equals (=)** to see the result.
4.  **Tap Clear (C)** if you made a mistake or want to start over.

It's that simple! No complex scientific buttons or confusing menus—just the math you need.

---

## ️ For Developers: Technical Deep Dive

This section provides detailed information about the technical implementation, architecture, and codebase organization.

### Architecture Overview
The application follows a **Clean Feature-First Architecture**. This ensures that the code is scalable, testable, and easy to maintain.

*   **Feature-First**: Code is organized by features (e.g., `calculator`) rather than by layer (e.g., `views`, `controllers`). This keeps related code together.
*   **Layered Approach**: content is separated into Logic (Bloc) and UI (View).

### State Management
State management is handled using **Flutter Bloc** (`flutter_bloc` package).
*   **Bloc Pattern**: Separates business logic from the UI.
*   **Events**: Actions that happen in the app (e.g., `CalculatorDigitPressed`, `CalculatorOperationPressed`).
*   **States**: The data snapshot at any given moment (e.g., `displayValue`, `bufferValue`).

### Code Structure
The source code is located in the `lib` directory:

```
lib/
├── app.dart                  # Main application widget (MaterialApp config)
├── main.dart                 # Entry point of the application
└── features/                 # Feature modules
    └── calculator/           # The Calculator Feature
        ├── bloc/             # Business Logic Layer
        │   ├── calculator_bloc.dart   # Logic implementation
        │   ├── calculator_event.dart  # User actions
        │   └── calculator_state.dart  # UI State definition
        └── view/             # Presentation Layer
            ├── calculator_page.dart   # Dependency Injection (BlocProvider)
            └── calculator_view.dart   # UI Widgets and Layout
```

### Key Components

#### 1. CalculatorBloc
*   **Role**: The "brain" of the calculator.
*   **Logic**: It listens for events (like pressing a digit) and emits new states (like updating the display).
*   **Math**: Handles the actual `+`, `-`, `*`, `/` calculations logic.

#### 2. CalculatorState
*   **Role**: Immutable data class holding the current status.
*   **Properties**:
    *   `displayValue`: The number currently shown on screen (String).
    *   `bufferValue`: The previously entered number stored for calculation (double).
    *   `operation`: The active math operation selected.

#### 3. CalculatorView
*   **Role**: The visual interface.
*   **Implementation**: Uses `BlocBuilder` to listen to the `CalculatorBloc` and rebuild the UI whenever the state changes.
*   **Design**: standard Grid layout for calculator buttons.

### Testing
The project includes unit tests for the business logic.
*   **Test Location**: `test/features/calculator/bloc/calculator_bloc_test.dart`
*   **Framework**: `bloc_test` is used for testing Blocs in a readable way.
*   **Coverage**: Tests cover addition, subtraction, multiplication, division, clearing, and state transitions.

### How to Run
1.  **Prerequisites**: Ensure you have Flutter installed.
2.  **Get Dependencies**: Run `flutter pub get`.
3.  **Run App**: `flutter run`.
4.  **Run Tests**: `flutter test`.
