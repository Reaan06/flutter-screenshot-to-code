---
name: flutter-screenshot-to-code
description: Convert UI screenshots into production-ready Flutter/Dart code. Detects Material/Cupertino patterns, maps widgets, generates responsive layouts with proper theming. Use when users provide screenshots of mobile apps, web apps, or UI designs and want Flutter code implementation.
---

# Flutter Screenshot to Code

Convert UI screenshots into production-ready Flutter/Dart code with accurate styling, proper widget hierarchy, responsive design, and platform-adaptive theming.

## How This Works

Given a screenshot of a UI design:
1. Analyze the visual design thoroughly through a Flutter lens
2. Map every visual element to the correct Flutter widget
3. Generate clean, idiomatic Dart code with proper theming
4. Deliver a complete, runnable implementation

```
📸 Screenshot → 🔍 Visual Analysis → 🧩 Widget Mapping → 📦 Production Code
```

---

## Phase 1: Visual Analysis

Examine the screenshot meticulously and identify:

### Layout Structure
- **Primary axis**: Is content stacked vertically (Column), horizontally (Row), or overlaid (Stack)?
- **Alignment**: Center, start, end, space-between, space-around, space-evenly?
- **Spacing**: Consistent padding/margin values (estimate in logical pixels — 4px/8px grid)
- **Constraints**: Fixed width, expanded, constrained, full-screen?
- **Overlaps**: Any elements that overlap others? (→ Stack + Positioned)
- **Scroll direction**: Vertical scroll, horizontal scroll, both, or none?
- **Safe area**: Does content respect the notch/status bar/home indicator?

### Platform Detection

**Critical first step**: Determine if the screenshot shows iOS or Android UI.

| iOS Indicators | Android Indicators |
|---------------|-------------------|
| San Francisco font | Roboto font |
| Large title navigation | Standard AppBar |
| iOS-style switches (green toggle) | Material switches (colored track) |
| Rounded rectangle buttons | Elevation-based buttons |
| Back chevron "‹" | Back arrow "←" |
| Bottom tab bar with labels | Bottom navigation with icons |
| Cupertino date picker (wheels) | Material date picker (calendar) |
| iOS status bar style | Material status bar |
| Grouped list sections | Divided list |
| Pull-to-refresh (iOS rubber band) | Material circular indicator |

**Decision**: If iOS indicators are dominant → use Cupertino widgets. Otherwise → Material widgets. When mixed or unclear → default to Material.

### Component Inventory

Catalog every visible component:

| Visual Element | Material Widget | Cupertino Widget | Notes |
|---------------|----------------|-----------------|-------|
| Top bar with title | `AppBar` / `SliverAppBar` | `CupertinoNavigationBar` / `CupertinoLargeTitleNavigationBar` | Check if scrollable/flexible |
| Back arrow | `IconButton(icon: Icon(Icons.arrow_back))` | `CupertinoNavigationBarBackButton` | |
| Tab bar (top) | `TabBar` + `TabBarView` | `CupertinoSegmentedControl` | |
| Bottom tab bar | `NavigationBar` / `BottomNavigationBar` | `CupertinoTabBar` | Note items count (2-5) |
| Card with shadow | `Card(elevation: N)` | `Container` with decoration | Note elevation and shape |
| Rounded image | `ClipRRect` + `Container` | Same | Note border radius |
| Text input | `TextField` / `TextFormField` | `CupertinoTextField` | Check decoration style |
| Button filled | `ElevatedButton` | `CupertinoButton.filled` | Note colors, radius |
| Button outlined | `OutlinedButton` | `CupertinoButton` (gray) | |
| Button text only | `TextButton` | `CupertinoButton` (plain) | |
| Icon | `Icon(Icons.xxx)` | `Icon(CupertinoIcons.xxx)` | Identify the icon |
| Circular avatar | `CircleAvatar` | Same | Note size and image/icon |
| Divider | `Divider()` | `CupertinoListSection` separator | Note thickness, color |
| Badge/notification dot | `Badge` / `Stack` + positioned dot | Same | |
| Bottom sheet | `showModalBottomSheet` / `DraggableScrollableSheet` | `showCupertinoModalBottomSheet` | |
| FAB | `FloatingActionButton` | N/A (use custom) | Note icon, color |
| Switch/toggle | `Switch` / `SwitchListTile` | `CupertinoSwitch` | Note color |
| Checkbox | `Checkbox` / `CheckboxListTile` | N/A (use custom or Material) | |
| Radio button | `Radio` / `RadioListTile` | N/A | |
| Slider | `Slider` | `CupertinoSlider` | |
| Progress indicator | `CircularProgressIndicator` / `LinearProgressIndicator` | `CupertinoActivityIndicator` | |
| Chip/Tag | `Chip` / `ActionChip` / `FilterChip` | N/A (use custom) | |
| Drawer | `Drawer` | `CupertinoSlidingPane` (3rd party) or custom | |
| SnackBar | `SnackBar` | N/A (use overlay) | |
| Dialog/Alert | `AlertDialog` / `Dialog` | `CupertinoAlertDialog` | |
| ListTile | `ListTile` | `CupertinoListTile` | Note leading, trailing, subtitle |
| List section | N/A | `CupertinoListSection.insetGrouped` | iOS grouped style |
| Grid of items | `GridView.builder` | Same | Note crossAxisCount |
| Scrollable list | `ListView.builder` | Same | |
| Nested scroll | `CustomScrollView` + `SliverList` / `SliverGrid` | Same | |
| Page indicator | `SmoothPageIndicator` / custom dots | `CupertinoPageScaffold` built-in | |
| Gradient background | `Container` + `BoxDecoration(gradient: ...)` | Same | Note colors and direction |
| Blur effect | `BackdropFilter` + `ImageFilter.blur` | Same | |
| Shimmer loading | `Shimmer` from `shimmer` package | Same | |
| Pull to refresh | `RefreshIndicator` | `CupertinoSliverRefreshControl` | |
| Hero animation target | `Hero` tag | Same | |
| SVG icon | `SvgPicture.asset` from `flutter_svg` | Same | |
| Network image | `CachedNetworkImage` from `cached_network_image` | Same | |
| Search bar | `TextField` in AppBar | `CupertinoSearchTextField` | |
| Segmented control | N/A | `CupertinoSegmentedControl` | |
| Action sheet | N/A | `CupertinoActionSheet` | |
| Date picker | `showDatePicker` (Material) | `CupertinoDatePicker` | |
| Time picker | `showTimePicker` (Material) | `CupertinoTimerPicker` | |
| Picker/wheel | N/A | `CupertinoPicker` | |
| Sliding panel | N/A | `CupertinoSlidingPane` | |

### Color Extraction
- **Primary color**: The dominant brand color
- **Secondary/accent**: The complementary color
- **Background**: Main background (note if gradient, pattern, or solid)
- **Surface**: Card/sheet/dialog backgrounds
- **Text colors**: Primary text, secondary/muted text, hint text, link text
- **Border/divider**: Subtle separator colors
- **Success/Error/Warning/Info**: Status colors if visible
- **Opacity**: Note any semi-transparent elements (glassmorphism, overlays)
- **Dark/Light**: Determine which theme is shown

### Typography
- **Headline large**: Estimate font size (24-32sp), weight (bold/medium)
- **Title**: 18-20sp, semi-bold
- **Body large**: 16sp, regular
- **Body medium**: 14sp, regular
- **Body small/Caption**: 12-13sp, sometimes colored
- **Label**: 11-12sp, uppercase or regular
- **Font family**: Default Material (Roboto)? Default iOS (SF Pro)? Custom (note if serif/mono/display)
- **Letter spacing**: Any unusual tracking?
- **Line height**: Single, 1.5, or tighter?

### Visual Effects
- **Shadows**: Elevation level (1-8dp typical), color, blur radius
- **Border radius**: Small (4-8), medium (12-16), large (24+), full (circle/pill)
- **Gradients**: Linear, radial, or sweep — note start/end colors and angle
- **Opacity**: Any `withOpacity()` elements (0.0 to 1.0)
- **Blur**: Backdrop blur for glass effects (sigmaX, sigmaY)
- **Border**: Solid, dashed, colored, gradient borders
- **Animation cues**: Loading spinners, progress bars, shimmer effects, transition indicators
- **Shadows/elevation**: Material elevation (0-24), custom shadows

---

## Phase 2: Widget Strategy

### Decision Tree for Layout

```
Content direction?
├── Vertical stack → Column / ListView / CustomScrollView
├── Horizontal row → Row / SingleChildScrollView(horizontal)
├── Overlapping layers → Stack + Positioned
├── Scrollable grid → GridView.builder
├── Scrollable single axis → ListView.builder
├── Mixed scroll directions → CustomScrollView + Slivers
├── Full-screen with fixed overlays → Stack (body + positioned children)
└── Tabbed content → TabBarView / PageView / IndexedStack

Content constraints?
├── Fill parent → Expanded + Flex
├── Shrink to content → IntrinsicHeight / IntrinsicWidth
├── Fixed size → SizedBox
├── Responsive → LayoutBuilder + MediaQuery
└── Scroll when needed → SingleChildScrollView (Column) / ListView

Scroll behavior?
├── All content visible → Column (no scroll)
├── Content exceeds screen → ListView / SingleChildScrollView
├── Header collapses on scroll → SliverAppBar
├── Different sections scroll differently → CustomScrollView + Slivers
└── Pull to refresh → RefreshIndicator / CupertinoSliverRefreshControl
```

### Widget Selection Rules

1. **Always prefer `Scaffold`** as the root — it provides Material structure (AppBar, FAB, bottom nav, drawer, snackbar)
2. **Use `SafeArea`** if the design shows content respecting notch/status bar (almost always for full-screen designs)
3. **Use `MediaQuery.of(context).size`** for screen-relative sizing
4. **Prefer `Expanded`/`Flexible`** over fixed widths for responsive layouts
5. **Use `LayoutBuilder`** when you need to adapt to parent constraints
6. **Wrap scrollable content** — never let content overflow (use `SingleChildScrollView`, `ListView`, or `CustomScrollView`)
7. **Use `Padding`/`SizedBox`** for consistent spacing (multiples of 4 or 8)
8. **Use `ListView.builder`** for dynamic lists — avoid `ListView(children: [...])` for lists with many items
9. **Use `GridView.builder`** for grids — not `GridView.count` with static children
10. **Wrap images** in `ClipRRect` or `ClipOval` when they need rounded corners

### State Management Decision

| Complexity | Recommendation | Why |
|-----------|---------------|-----|
| Single screen, no shared state | `StatefulWidget` | Simplest, no dependencies |
| Single screen, form state | `StatefulWidget` + `Form` | Built-in validation |
| Multiple screens, simple shared state | `Provider` | Easy to learn, good enough for small apps |
| Complex state, many providers | `Riverpod` | Compile-safe, testable, no context needed |
| Complex events, many transitions | `BLoC` / `Cubit` | Predictable state, easy to test |
| Quick prototype | `GetX` | Fastest to write, less boilerplate |
| Enterprise/team project | `Riverpod` or `BLoC` | Scalable, testable, enforced patterns |

**Default for screenshot-to-code**: `StatefulWidget` unless the design clearly implies complex state.

---

## Phase 3: Code Generation

### File Structure

For a single screen, generate:
```
lib/
├── features/
│   └── {feature_name}/
│       └── screens/
│           └── {screen_name}_screen.dart
```

For multiple related screens:
```
lib/
├── features/
│   └── {feature_name}/
│       ├── screens/
│       │   ├── {screen_a}_screen.dart
│       │   └── {screen_b}_screen.dart
│       ├── widgets/
│       │   └── {reusable_widget}.dart
│       └── providers/
│           └── {state_provider}.dart
```

For a complete app:
```
lib/
├── main.dart
├── app.dart
├── config/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   ├── routes/
│   │   └── app_router.dart
│   └── constants/
│       └── app_constants.dart
├── features/
│   └── {feature_name}/
│       ├── screens/
│       ├── widgets/
│       ├── providers/ or blocs/
│       └── models/
└── shared/
    └── widgets/
        ├── app_bar.dart
        ├── buttons.dart
        └── cards.dart
```

### Code Template

```dart
import 'package:flutter/material.dart';

class {ScreenName}Screen extends StatefulWidget {
  const {ScreenName}Screen({super.key});

  @override
  State<{ScreenName}Screen> createState() => _{ScreenName}ScreenState();
}

class _{ScreenName}ScreenState extends State<{ScreenName}Screen> {
  // State variables

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Body, AppBar, FAB, etc.
    );
  }
}
```

### Cupertino Code Template

```dart
import 'package:flutter/cupertino.dart';

class {ScreenName}Screen extends StatelessWidget {
  const {ScreenName}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('{Screen Title}'),
      ),
      child: SafeArea(
        child: /* content */,
      ),
    );
  }
}
```

### Theming Rules

1. **Always use `Theme.of(context)`** — never hardcode colors/sizes
2. **Use `colorScheme`** for semantic colors (primary, secondary, surface, error)
3. **Use `textTheme`** for text styles (headlineLarge, bodyMedium, etc.)
4. **Extract custom colors** to a `app_colors.dart` file if the design uses colors not in the default scheme
5. **Define custom `TextTheme`** if the design uses specific font sizes/weights
6. **Use `const` constructors** wherever possible for performance
7. **Use semantic color roles**: `colorScheme.onPrimary`, `colorScheme.onSurface`, etc.

### Responsive Design Rules

```dart
// Breakpoints
const phone = 600;    // < 600
const tablet = 1024;  // 600 - 1024
const desktop = 1024; // > 1024

// Responsive width check
final width = MediaQuery.of(context).size.width;
final isPhone = width < 600;
final isTablet = width >= 600 && width < 1024;
final isDesktop = width >= 1024;

// Responsive padding
final padding = EdgeInsets.symmetric(
  horizontal: isPhone ? 16 : isTablet ? 32 : 48,
);

// Responsive grid
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: isPhone ? 2 : isTablet ? 3 : 4,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.75,
  ),
  // ...
)

// Responsive text
final titleSize = isPhone ? 20.0 : isTablet ? 24.0 : 28.0;
```

### Spacing System

Use a consistent spacing scale based on 4px increments:

| Token | Value | Usage |
|-------|-------|-------|
| xxs | 2 | Micro spacing (icon to text) |
| xs | 4 | Tight inner spacing |
| sm | 8 | Default inner spacing |
| md | 12 | Between related items |
| lg | 16 | Standard padding |
| xl | 24 | Section separation |
| 2xl | 32 | Major section breaks |
| 3xl | 48 | Screen-level spacing |
| 4xl | 64 | Hero section spacing |

### Border Radius System

| Token | Value | Usage |
|-------|-------|-------|
| none | 0 | No rounding |
| xs | 4 | Small elements (badges, chips) |
| sm | 8 | Buttons, inputs, small cards |
| md | 12-16 | Cards, bottom sheets, dialogs |
| lg | 24 | Large cards, modals |
| xl | 32 | Featured cards |
| full | 999 | Avatars, circular elements, pills |

---

## Phase 4: Common Patterns

> Detailed code examples for each pattern are in the `patterns/` directory.

### Login / Auth Screen
**Structure**: Gradient/full background → Centered card/form
- See `patterns/login-auth.md` for complete implementation

### Dashboard / Home Screen
**Structure**: AppBar → Scrollable content with sections
- See `patterns/dashboard-home.md` for complete implementation

### Detail / Profile Screen
**Structure**: Scrollable header with image → Content
- CustomScrollView + SliverAppBar + SliverToBoxAdapter

### Form Screen
**Structure**: AppBar → Form with validation
- Form + GlobalKey<FormState> + TextFormField with validators

### List with Search
**Structure**: AppBar with search → Filterable list
- TextField in AppBar bottom + ListView.builder

### Onboarding / PageView
**Structure**: PageView with dots indicator
- PageView.builder + animated page indicators + Skip/Next/Done

### Bottom Navigation
**Structure**: Scaffold with NavigationBar + IndexedStack
- NavigationBar with 3-5 items + IndexedStack for state preservation

### Settings / Preferences
**Structure**: ListView with sections
- SwitchListTile, RadioListTile, ListTile with chevron

---

## Phase 5: Cupertino/iOS Patterns

See `reference/cupertino-catalog.md` for complete Cupertino widget mapping.

### When to Use Cupertino
- Screenshot shows iOS UI indicators (SF font, large title nav, iOS switches)
- User explicitly requests iOS-style interface
- Building a platform-specific iOS app

### Key Cupertino Differences
- `CupertinoPageScaffold` instead of `Scaffold`
- `CupertinoNavigationBar` instead of `AppBar`
- `CupertinoButton` instead of `ElevatedButton`/`TextButton`
- `CupertinoTextField` instead of `TextField`
- `CupertinoSwitch` instead of `Switch`
- `CupertinoSlider` instead of `Slider`
- `CupertinoActionSheet` instead of `showModalBottomSheet`
- `CupertinoAlertDialog` instead of `AlertDialog`
- `CupertinoListSection.insetGrouped` for grouped settings

### Cupertino Theming
```dart
CupertinoTheme(
  data: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  ),
  child: MaterialApp(
    // ...
  ),
)
```

---

## Phase 6: Navigation

See `patterns/navigation-routing.md` for complete routing implementations.

### GoRouter (Recommended)

```dart
// Route definitions
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductScreen(productId: id);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
      ],
    ),
  ],
  redirect: (context, state) {
    final isLoggedIn = /* auth check */;
    if (!isLoggedIn && state.matchedLocation != '/login') {
      return '/login';
    }
    return null;
  },
);
```

### Page Transitions

```dart
// Cupertino-style (slide from right)
PageRouteBuilder(
  pageBuilder: (_, __, ___) => const NextScreen(),
  transitionsBuilder: (_, animation, __, child) {
    return CupertinoTransition(
      child: child,
      // or SlideTransition for custom direction
    );
  },
)
```

---

## Phase 7: Animations

See `patterns/animations-motion.md` for complete animation implementations.

### Implicit Animations (Easiest)

```dart
// AnimatedContainer — animates size, color, decoration changes
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _isExpanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _isSelected ? Colors.blue : Colors.grey,
    borderRadius: BorderRadius.circular(_isSelected ? 16 : 8),
  ),
  child: /* ... */,
)

// AnimatedOpacity — fade in/out
AnimatedOpacity(
  opacity: _isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 200),
  child: /* ... */,
)

// AnimatedSwitcher — cross-fade between children
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: _showIcon
      ? Icon(Icons.star, key: const ValueKey('star'))
      : Icon(Icons.star_border, key: const ValueKey('border')),
)
```

### Hero Animations

```dart
// Route A — hero source
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.image),
)

// Route B — hero destination
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.image, height: 300),
)
```

### Staggered List Animations

```dart
// Controller + Interval for stagger effect
final _controller = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 1200),
);

// Each item animates at a different time
children: List.generate(items.length, (i) {
  final start = i * 0.1;
  final end = start + 0.4;
  final slideAnimation = Tween<Offset>(
    begin: const Offset(0, 0.3),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Interval(start, end, curve: Curves.easeOut),
  ));
  final fadeAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Interval(start, end, curve: Curves.easeOut),
  ));

  return FadeTransition(
    opacity: fadeAnimation,
    child: SlideTransition(
      position: slideAnimation,
      child: ListTile(/* ... */),
    ),
  );
})
```

### Lottie Integration

```dart
// From assets
Lottie.asset('assets/animations/loading.json', width: 200, height: 200)

// From network
Lottie.network('https://example.com/animation.json')

// With controller for custom playback
Lottie.asset(
  'assets/animations/success.json',
  controller: _controller,
  onLoaded: (composition) {
    _controller
      ..duration = composition.duration
      ..forward();
  },
)
```

---

## Phase 8: Dark Mode

### ThemeMode Setup

```dart
MaterialApp(
  theme: AppTheme.light(),       // Light theme
  darkTheme: AppTheme.dark(),    // Dark theme
  themeMode: ThemeMode.system,   // Follow system setting
)
```

### Dynamic Color Scheme (Material You)

```dart
// Android 12+ dynamic color
final dynamicColor = await DynamicColorPlugin.createIfAvailable();

ColorScheme.fromSeed(
  seedColor: Colors.blue,
  dynamicSchemeOverride: dynamicColor, // Falls back to seed if unavailable
)
```

### Dark Mode Color Adjustments
- Reduce elevation/shadow intensity in dark mode
- Use surface colors instead of white backgrounds
- Increase text contrast (use higher opacity on dark backgrounds)
- Use `colorScheme.surfaceContainerHighest` for cards instead of `surface`
- Reduce border opacity in dark mode

```dart
// Adaptive colors
final cardColor = Theme.of(context).brightness == Brightness.dark
    ? colorScheme.surfaceContainerHighest
    : colorScheme.surface;
```

---

## Phase 9: Accessibility

Always include:
- `Semantics` wrapper for custom interactive elements
- `tooltip` on IconButtons
- `semanticLabel` on images
- Sufficient color contrast (4.5:1 minimum for normal text, 3:1 for large text)
- `Focus` and keyboard navigation support where applicable
- `excludeFromSemantics: true` on decorative images
- Minimum touch target size: 48x48dp

```dart
// Example: Accessible custom button
Semantics(
  button: true,
  label: 'Add to cart',
  child: GestureDetector(
    onTap: _addToCart,
    child: Container(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      /* ... */,
    ),
  ),
)

// Example: Decorative image
Image.asset(
  'assets/decorative.png',
  excludeFromSemantics: true,
)

// Example: Icon button with tooltip
Tooltip(
  message: 'Delete item',
  child: IconButton(
    icon: Icon(Icons.delete),
    onPressed: _delete,
  ),
)
```

---

## Phase 10: Testing

See `templates/testing.md` for complete test implementations.

### Widget Test Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('renders all form fields', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
    });

    testWidgets('shows error on empty submit', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('validates email format', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      await tester.enterText(
        find.byType(TextField).first,
        'invalid-email',
      );
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid email'), findsOneWidget);
    });
  });
}
```

---

## Phase 11: Performance

### Must-Do Optimizations
1. **Use `const` constructors** wherever possible
2. **Use `ListView.builder`** for dynamic lists (lazy rendering)
3. **Use `GridView.builder`** for grids (lazy rendering)
4. **Add `RepaintBoundary`** around complex widgets that change frequently
5. **Optimize images**: use `cacheWidth`/`cacheHeight` to decode at display size
6. **Use `AutomaticKeepAliveClientMixin`** for tab views that shouldn't rebuild
7. **Avoid `setState` in build()** — only rebuild what changed

```dart
// Image optimization
Image.asset(
  'assets/hero.png',
  width: 300,
  height: 200,
  cacheWidth: 600,  // 2x for retina
  cacheHeight: 400,
  fit: BoxFit.cover,
)

// Keep-alive for tabs
class _TabScreenState extends State<TabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return /* ... */;
  }
}
```

---

## Phase 12: Delivery Checklist

Before delivering the final code, verify:

- [ ] **All colors** come from `Theme.of(context).colorScheme` or a defined constants file
- [ ] **All text styles** come from `Theme.of(context).textTheme` or a defined constants file
- [ ] **Spacing** follows the 4px grid system (4, 8, 12, 16, 24, 32, 48)
- [ ] **Border radius** is consistent across similar components
- [ ] **No overflow errors** — all scrollable content is properly wrapped
- [ ] **Responsive** — works on different screen sizes (phone + tablet minimum)
- [ ] **Accessible** — semantic labels, sufficient contrast, proper hit targets (48dp min)
- [ ] **State management** matches complexity (StatefulWidget minimum)
- [ ] **Imports** are correct and necessary
- [ ] **Code compiles** — no syntax errors, all widgets properly nested
- [ ] **Naming** follows Dart conventions (camelCase variables, PascalCase classes)
- [ ] **const constructors** used wherever possible
- [ ] **ListView.builder** used for dynamic lists
- [ ] **Images optimized** with cacheWidth/cacheHeight
- [ ] **Platform-appropriate** — Material or Cupertino based on screenshot
- [ ] **Dark mode considered** — colors work in both themes
- [ ] **No hardcoded strings** in UI (use constants or localization)

---

## Output Format

### Single Screen

Deliver a single, complete `.dart` file with:
1. All imports at the top
2. The StatefulWidget/StatelessWidget class
3. The State class with `build()` method
4. Any helper methods for complex sub-sections
5. Comments explaining non-obvious design decisions

### Multiple Screens

Deliver:
1. A directory structure showing file organization
2. Each screen as a separate `.dart` file
3. Shared widgets in a `widgets/` directory
4. Theme/constants in a `theme/` directory
5. A `main.dart` showing how to wire them together

### With Theming

When the design uses a custom color palette, also deliver:
1. `app_colors.dart` — color constants
2. `app_theme.dart` — `ThemeData` configuration (light + dark)
3. `app_typography.dart` — custom `TextTheme`

### With Navigation

When the design implies multiple screens:
1. `app_router.dart` — GoRouter route definitions
2. Main scaffold with bottom nav / drawer
3. Navigation between screens

---

## Handling Ambiguity

When the screenshot is unclear:

1. **Make reasonable assumptions** based on Material 3 / Cupertino patterns
2. **Document assumptions** in code comments:
   ```dart
   // Assumption: This appears to be a card with 12px border radius
   // based on visual similarity to Material 3 card standards
   ```
3. **Suggest alternatives** when there are multiple valid interpretations
4. **Ask for clarification** only on critical layout decisions (e.g., "Is this a bottom sheet or a new screen?")
5. **Prioritize the most common interpretation** when ambiguous

---

## Anti-Patterns to Avoid

- ❌ Hardcoding colors (`Color(0xFF123456)`) without extracting to constants
- ❌ Using `Container` with `decoration` when a simpler widget exists (e.g., `Card`, `ClipRRect`)
- ❌ Nesting `Column` inside `Column` without `Expanded` in scrollable contexts
- ❌ Using `Stack` when `Column`/`Row` would suffice
- ❌ Ignoring safe area (notch, status bar, home indicator)
- ❌ Using `SizedBox(height: double.infinity)` instead of `Expanded`
- ❌ Mixing Material and Cupertino widgets inconsistently
- ❌ Forgetting `const` constructors where possible
- ❌ Not using `ListView.builder` for dynamic lists (avoid `ListView(children: [...])` for long lists)
- ❌ Hardcoded pixel values for padding/margin (use the spacing system)
- ❌ Using `setState` when no state actually changes
- ❌ Building widget trees so deep they become unreadable (extract helper methods/widgets)
- ❌ Using `!` (null assertion) without null check (use `?.` or `??`)
- ❌ Ignoring keyboard overlap on form screens (use SingleChildScrollView)
- ❌ Not disposing controllers (TextEditingController, ScrollController, etc.)
- ❌ Using `print()` for debugging in production code
- ❌ Creating new widget instances in build() that should be const
- ❌ Putting business logic in widget build methods

---

## Quality Bar

The generated code should be so clean that:
1. It compiles without errors on first run
2. It looks 90%+ identical to the screenshot
3. A senior Flutter developer would approve it in code review
4. It follows [Effective Dart](https://dart.dev/effective-dart) guidelines
5. It could be shipped to production with minimal modifications

---

## Supporting Files

This skill includes detailed reference and pattern files:

### Reference Guides
- `reference/widget-catalog.md` — Complete Flutter widget mapping catalog
- `reference/cupertino-catalog.md` — Cupertino (iOS-style) widget catalog
- `reference/packages.md` — Recommended Flutter packages by category
- `reference/theming.md` — Deep dive into Material 3 theming

### Code Patterns
- `patterns/login-auth.md` — Login, signup, authentication screens
- `patterns/dashboard-home.md` — Dashboard, home, feed screens
- `patterns/settings-preferences.md` — Settings, preferences screens
- `patterns/onboarding-pageview.md` — Onboarding, walkthrough screens
- `patterns/forms-validation.md` — Forms, inputs, validation
- `patterns/navigation-routing.md` — Navigation, routing, transitions
- `patterns/animations-motion.md` — Animations, motion, micro-interactions

### Implementation Templates
- `templates/state-management.md` — Riverpod, BLoC, Provider, StatefulWidget
- `templates/testing.md` — Widget tests, golden tests, integration tests
- `templates/responsive.md` — Responsive design, breakpoints, adaptive layouts
