---
name: testing
description: Widget testing patterns for Flutter. Covers unit tests, widget tests, golden tests, and integration tests.
---

# Testing Templates

## Test Structure

```
test/
├── unit/
│   ├── models/
│   │   └── user_test.dart
│   └── services/
│       └── auth_service_test.dart
├── widget/
│   ├── login_screen_test.dart
│   ├── dashboard_screen_test.dart
│   └── widgets/
│       └── stat_card_test.dart
├── golden/
│   ├── login_screen_golden.png
│   └── dashboard_screen_golden.png
└── integration/
    └── app_test.dart
```

## Widget Test Template

### Finding Widgets
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('renders all form elements', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      // Find by type
      expect(find.byType(TextField), findsNWidgets(2));

      // Find by text
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);

      // Find by icon
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outlined), findsOneWidget);

      // Find by key
      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });
  });
}
```

### Testing Taps and Interactions
```dart
testWidgets('calls onLogin when form is valid', (tester) async {
  bool loginCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: LoginScreen(
        onLogin: () => loginCalled = true,
      ),
    ),
  );

  // Enter text
  await tester.enterText(
    find.byType(TextField).first,
    'test@example.com',
  );
  await tester.enterText(
    find.byType(TextField).last,
    'password123',
  );

  // Tap button
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();

  expect(loginCalled, isTrue);
});
```

### Testing Form Validation
```dart
testWidgets('shows error on empty email', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: LoginScreen()),
  );

  // Tap submit without entering data
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();

  expect(find.text('Please enter your email'), findsOneWidget);
});

testWidgets('shows error on invalid email', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: LoginScreen()),
  );

  await tester.enterText(
    find.byType(TextField).first,
    'invalid-email',
  );
  await tester.tap(find.text('Sign In'));
  await tester.pumpAndSettle();

  expect(find.text('Please enter a valid email'), findsOneWidget);
});
```

### Testing Navigation
```dart
testWidgets('navigates to signup on tap', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: LoginScreen()),
  );

  await tester.tap(find.text('Sign Up'));
  await tester.pumpAndSettle();

  expect(find.byType(SignupScreen), findsOneWidget);
});
```

### Testing with Providers
```dart
testWidgets('renders with provider', (tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MaterialApp(home: CartScreen()),
    ),
  );

  expect(find.text('Your cart is empty'), findsOneWidget);
});
```

### Testing with BLoC
```dart
testWidgets('renders with bloc', (tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => CounterCubit(),
      child: const MaterialApp(home: CounterScreen()),
    ),
  );

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

### Testing Scrollable Content
```dart
testWidgets('scrolls to reveal more items', (tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: ItemListScreen()),
  );

  // Scroll down
  await tester.scrollUntilVisible(
    find.text('Item 20'),
    500,
    scrollable: find.byType(Scrollable).first,
  );

  expect(find.text('Item 20'), findsOneWidget);
});
```

## Golden Tests

```dart
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testAppWidgetSmokeTester('LoginScreen golden', (tester) async {
    await tester.pumpAppWidget(
      const MaterialApp(home: LoginScreen()),
    );

    await multiScreenGolden(tester, 'login_screen', [
      const Device(size: Size(375, 812), name: 'phone'),
      const Device(size: Size(768, 1024), name: 'tablet'),
    ]);
  });
}

// Update golden files
// flutter test --update-goldens
```

## Complete Login Screen Test

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  group('LoginScreen', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: LoginScreen(authService: mockAuthService)),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('shows validation errors on empty submit', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: LoginScreen(authService: mockAuthService)),
      );

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('calls auth service on valid submit', (tester) async {
      when(() => mockAuthService.login(any(), any()))
          .thenAnswer((_) async => User(id: '1', name: 'Test'));

      await tester.pumpWidget(
        MaterialApp(home: LoginScreen(authService: mockAuthService)),
      );

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      verify(() => mockAuthService.login('test@example.com', 'password123')).called(1);
    });

    testWidgets('shows error on failed login', (tester) async {
      when(() => mockAuthService.login(any(), any()))
          .thenThrow(Exception('Invalid credentials'));

      await tester.pumpWidget(
        MaterialApp(home: LoginScreen(authService: mockAuthService)),
      );

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'wrong');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Invalid'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: LoginScreen(authService: mockAuthService)),
      );

      // Password should be obscured
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // Tap to toggle
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
```

## Integration Test Template

```dart
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full login flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify login screen
    expect(find.text('Sign In'), findsOneWidget);

    // Enter credentials
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');

    // Tap login
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify navigation to home
    expect(find.text('Dashboard'), findsOneWidget);
  });
}
```

## Test Utilities

```dart
// test/helpers/test_helpers.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget testableWidget(Widget child, {ThemeMode themeMode = ThemeMode.light}) {
  return MaterialApp(
    themeMode: themeMode,
    theme: ThemeData(useMaterial3: true),
    darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
    home: child,
  );
}

Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(testableWidget(widget));
  await tester.pumpAndSettle();
}
```
