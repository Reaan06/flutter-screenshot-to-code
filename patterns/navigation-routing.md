---
name: navigation-routing
description: Navigation, routing, and screen transition patterns for Flutter.
---

# Navigation & Routing Patterns

## GoRouter Setup (Recommended)

```dart
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),

    // Shell route for bottom navigation
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // Detail routes
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductScreen(productId: id);
      },
    ),
  ],

  // Redirect for auth
  redirect: (context, state) {
    final isLoggedIn = /* auth check */;
    final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation == '/signup';

    if (!isLoggedIn && !isAuthRoute) return '/login';
    if (isLoggedIn && isAuthRoute) return '/home';
    return null;
  },

  // Error page
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);
```

## Main Scaffold with Bottom Navigation

```dart
class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) {
          switch (index) {
            case 0: context.go('/home');
            case 1: context.go('/search');
            case 2: context.go('/profile');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
```

## Page Transitions

### Material Transition (Default)
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const DetailScreen()),
);
```

### Cupertino Transition (iOS-style)
```dart
Navigator.push(
  context,
  CupertinoPageRoute(builder: (_) => const DetailScreen()),
);
```

### Custom Fade Transition
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (_, __, ___) => const DetailScreen(),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        child: child,
      );
    },
  ),
);
```

### Custom Slide Transition
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (_, __, ___) => const DetailScreen(),
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);
```

### Shared Axis Transition (Material Motion)
```dart
import 'package:animations/animations.dart';

Navigator.push(
  context,
  SharedAxisTransition(
    animation: animation,
    secondaryAnimation: secondaryAnimation,
    transitionType: SharedAxisTransitionType.horizontal,
    child: const DetailScreen(),
  ),
);
```

## Passing Data Between Screens

### Using Route Parameters
```dart
// Push
context.push('/product/123');

// Read in destination
final id = GoRouterState.of(context).pathParameters['id']!;
```

### Using Extra Data
```dart
// Push with extra
context.push('/product/123', extra: product);

// Read in destination
final product = state.extra as Product;
```

### Navigator Return Values
```dart
// Push and wait for result
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(builder: (_) => const SelectionScreen()),
);

if (result != null) {
  // Use result
}

// Pop with result
Navigator.pop(context, 'selected_value');
```

## Auth Guard Pattern

```dart
// GoRouter redirect
redirect: (context, state) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      final isAuthRoute = ['/login', '/signup'].contains(state.matchedLocation);
      if (user == null && !isAuthRoute) return '/login';
      if (user != null && isAuthRoute) return '/home';
      return null;
    },
    loading: () => '/loading',
    error: (_, __) => '/login',
  );
},
```

## Back Navigation Handling

```dart
// Modern approach (Flutter 3.12+)
PopScope(
  canPop: _hasUnsavedChanges ? false : true,
  onPopInvokedWithResult: (didPop, result) {
    if (!didPop) {
      _showUnsavedChangesDialog();
    }
  },
  child: /* ... */,
)

// Show dialog on back
PopScope(
  canPop: false,
  onPopInvokedWithResult: (didPop, result) {
    if (didPop) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('You have unsaved changes.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  },
  child: /* ... */,
)
```

## 404 / Unknown Route

```dart
// GoRouter
GoRoute(
  path: '/404',
  builder: (context, state) => const NotFoundScreen(),
),
errorBuilder: (context, state) => const NotFoundScreen(),

// Material
onGenerateRoute: (settings) {
  return MaterialPageRoute(builder: (_) => const NotFoundScreen());
}
```

## Deep Linking with GoRouter

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductScreen(productId: id);
      },
    ),
  ],

  // Handle deep links
  redirect: (context, state) {
    // Parse and validate deep link
    final uri = Uri.parse(state.matchedLocation);
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'product') {
      final id = uri.pathSegments[1];
      if (id.isEmpty) return '/404';
    }
    return null;
  },
);
```
