---
name: flutter-screenshot-to-code
description: Convert UI screenshots into production-ready Flutter/Dart code. Detects Material/Cupertino patterns, maps widgets, generates responsive layouts with proper theming. Use when users provide screenshots of mobile apps, web apps, or UI designs and want Flutter code implementation.
---

# Flutter Screenshot to Code

Convert UI screenshots into production-ready Flutter/Dart code with accurate styling, proper widget hierarchy, and responsive design.

## How This Works

Given a screenshot of a UI design:
1. Analyze the visual design thoroughly through a Flutter lens
2. Map every visual element to the correct Flutter widget
3. Generate clean, idiomatic Dart code with proper theming
4. Deliver a complete, runnable implementation

---

## Phase 1: Visual Analysis

Examine the screenshot meticulously and identify:

### Layout Structure
- **Primary axis**: Is content stacked vertically (Column), horizontally (Row), or overlaid (Stack)?
- **Alignment**: Center, start, end, space-between, space-around, space-evenly?
- **Spacing**: Consistent padding/margin values (estimate in logical pixels — 8px grid)
- **Constrains**: Fixed width, expanded, constrained, full-screen?
- **Overlaps**: Any elements that overlap others? (→ Stack + Positioned)

### Component Inventory
Catalog every visible component:

| Visual Element | Flutter Widget | Notes |
|---------------|----------------|-------|
| Top bar with title | `AppBar` / `SliverAppBar` | Check if scrollable/flexible |
| Back arrow | `leading: IconButton(icon: Icon(Icons.arrow_back))` | |
| Tab bar | `TabBar` + `TabBarView` | Or `BottomNavigationBar` if at bottom |
| Card with shadow | `Card(elevation: N)` | Note elevation and shape |
| Rounded image | `ClipRRect` + `Container` | Note border radius |
| Text input | `TextField` / `TextFormField` | Check decoration style |
| Button filled | `ElevatedButton` | Note colors, radius |
| Button outlined | `OutlinedButton` | |
| Button text only | `TextButton` | |
| Icon | `Icon(Icons.xxx)` | Identify the Material icon |
| Circular avatar | `CircleAvatar` | Note size and image/icon |
| Divider | `Divider()` | Note thickness, color |
| Badge/notification dot | `Badge` / `Stack` + positioned container | |
| Bottom sheet | `showModalBottomSheet` / `DraggableScrollableSheet` | |
| FAB | `FloatingActionButton` | Note icon, color |
| Switch/toggle | `Switch` / `SwitchListTile` | |
| Checkbox | `Checkbox` / `CheckboxListTile` | |
| Radio button | `Radio` / `RadioListTile` | |
| Slider | `Slider` | |
| Progress indicator | `CircularProgressIndicator` / `LinearProgressIndicator` | |
| Chip/Tag | `Chip` / `ActionChip` / `FilterChip` | |
| Drawer | `Drawer` | |
| SnackBar | `SnackBar` | |
| Dialog/Alert | `showDialog` + `AlertDialog` / `Dialog` | |
| ListTile | `ListTile` | Note leading, trailing, subtitle |
| Grid of items | `GridView.builder` | Note crossAxisCount |
| Scrollable list | `ListView.builder` | |
| Nested scroll | `CustomScrollView` + `SliverList` / `SliverGrid` | |
| Bottom nav | `BottomNavigationBar` | Note items count |
| Page indicator | `SmoothPageIndicator` / `PageView` | |
| Gradient background | `Container` + `BoxDecoration(gradient: ...)` | Note colors |
| Blur effect | `BackdropFilter` + `ImageFilter.blur` | |
| Shimmer loading | `Shimmer` from `shimmer` package | |
| Pull to refresh | `RefreshIndicator` | |
| Hero animation target | `Hero` tag | |
| SVG icon | `SvgPicture.asset` from `flutter_svg` | |
| Cached network image | `CachedNetworkImage` from `cached_network_image` | |

### Color Extraction
- **Primary color**: The dominant brand color
- **Secondary/accent**: The complementary color
- **Background**: Main background (note if gradient)
- **Surface**: Card/sheet backgrounds
- **Text colors**: Primary text, secondary text, hint text
- **Border/divider**: Subtle separator colors
- **Success/Error/Warning**: Status colors if visible
- **Opacity**: Note any semi-transparent elements

### Typography
- **Headline large**: Estimate font size (24-32sp), weight (bold/medium)
- **Title**: 18-20sp, semi-bold
- **Body**: 14-16sp, regular
- **Caption/label**: 12-13sp, sometimes colored
- **Font family**: Default Material? Or custom (note if serif/mono/display)

### Visual Effects
- **Shadows**: Elevation level (1-8dp typical)
- **Border radius**: Small (8), medium (12-16), large (24+), full (circle)
- **Gradients**: Linear, radial, or sweep — note start/end colors and angle
- **Opacity**: Any `withOpacity()` elements
- **Blur**: Backdrop blur for glass effects
- **Animation cues**: Any motion indicators (dots, progress, transitions)

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
└── Full-screen with fixed overlays → Stack (body + positioned children)
```

### Widget Selection Rules

1. **Always prefer `Scaffold`** as the root — it provides Material structure
2. **Use `SafeArea`** if the design shows content respecting notch/status bar
3. **Use `MediaQuery.of(context).size`** for screen-relative sizing
4. **Prefer `Expanded`/`Flexible`** over fixed widths for responsive layouts
5. **Use `LayoutBuilder`** when you need to adapt to parent constraints
6. **Wrap scrollable content** — never let content overflow
7. **Use `Padding`/`SizedBox`** for consistent spacing (multiples of 4 or 8)

### State Management Decision

| Complexity | Recommendation |
|-----------|---------------|
| Single screen, no shared state | `StatefulWidget` |
| Multiple screens, simple shared state | `Provider` or `Riverpod` |
| Complex state, many interactions | `Riverpod` or `Bloc` |
| Form-heavy screens | `Form` + `GlobalKey<FormState>` |
| Animation-heavy | `AnimationController` + `Tween` |

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
│       └── widgets/
│           └── {reusable_widget}.dart
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

    return Scaffold(
      // Body, AppBar, FAB, etc.
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

### Responsive Design Rules

```dart
// Responsive width check
final isWide = MediaQuery.of(context).size.width > 600;

// Responsive padding
final padding = MediaQuery.of(context).size.width > 600
    ? const EdgeInsets.symmetric(horizontal: 32)
    : const EdgeInsets.symmetric(horizontal: 16);

// Responsive grid
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.75,
  ),
  // ...
)
```

### Spacing System

Use a consistent spacing scale based on 4px increments:

| Token | Value | Usage |
|-------|-------|-------|
| xs | 4 | Tight inner spacing |
| sm | 8 | Default inner spacing |
| md | 12 | Between related items |
| lg | 16 | Standard padding |
| xl | 24 | Section separation |
| 2xl | 32 | Major section breaks |
| 3xl | 48 | Screen-level spacing |

### Border Radius System

| Token | Value | Usage |
|-------|-------|-------|
| sm | 8 | Buttons, chips, small cards |
| md | 12-16 | Cards, inputs, bottom sheets |
| lg | 24 | Large cards, dialogs |
| full | 999 | Avatars, circular elements |

---

## Phase 4: Common Patterns

### Pattern: Login / Auth Screen

```dart
// Structure: Gradient/full background → Centered card/form
Scaffold(
  body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [primaryColor, secondaryColor],
      ),
    ),
    child: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo / illustration
              // Title text
              // Subtitle text
              // Email field
              // Password field
              // Forgot password link
              // Login button
              // Sign up link
            ],
          ),
        ),
      ),
    ),
  ),
)
```

### Pattern: Dashboard / Home Screen

```dart
// Structure: AppBar → Scrollable content with sections
Scaffold(
  appBar: AppBar(title: Text('Dashboard')),
  body: ListView(
    padding: const EdgeInsets.all(16),
    children: [
      // Greeting / user info section
      // Stats / summary cards (Row with Expanded children)
      // Quick actions grid
      // Recent items list
      // etc.
    ],
  ),
  bottomNavigationBar: BottomNavigationBar(items: [...]),
)
```

### Pattern: Detail / Profile Screen

```dart
// Structure: Scrollable header with image → Content
Scaffold(
  body: CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 250,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(..., fit: BoxFit.cover),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [/* content */],
          ),
        ),
      ),
    ],
  ),
)
```

### Pattern: Form Screen

```dart
// Structure: AppBar → Form with validation
final _formKey = GlobalKey<FormState>();

Scaffold(
  appBar: AppBar(title: Text('Form')),
  body: Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            return null;
          },
        ),
        // More fields...
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Submit
            }
          },
          child: Text('Submit'),
        ),
      ],
    ),
  ),
)
```

### Pattern: List with Search

```dart
// Structure: AppBar with search → Filterable list
Scaffold(
  appBar: AppBar(
    title: Text('Items'),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    ),
  ),
  body: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(child: Icon(Icons.item)),
        title: Text(items[index].name),
        subtitle: Text(items[index].description),
        trailing: Icon(Icons.chevron_right),
      );
    },
  ),
)
```

### Pattern: Onboarding / PageView

```dart
// Structure: PageView with dots indicator
Scaffold(
  body: Stack(
    children: [
      PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[index],
      ),
      Positioned(
        bottom: 48,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == _currentPage ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == _currentPage
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)
```

### Pattern: Bottom Navigation

```dart
// Structure: Scaffold with BottomNavigationBar + IndexedStack
int _currentIndex = 0;

Scaffold(
  body: IndexedStack(
    index: _currentIndex,
    children: [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ],
  ),
  bottomNavigationBar: NavigationBar(
    selectedIndex: _currentIndex,
    onDestinationSelected: (i) => setState(() => _currentIndex = i),
    destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
      NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
)
```

### Pattern: Settings / Preferences

```dart
// Structure: ListView with sections
Scaffold(
  appBar: AppBar(title: Text('Settings')),
  body: ListView(
    children: [
      _buildSection('Account', [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {},
        ),
        SwitchListTile(
          secondary: Icon(Icons.notifications),
          title: Text('Notifications'),
          value: _notificationsEnabled,
          onChanged: (v) => setState(() => _notificationsEnabled = v),
        ),
      ]),
      Divider(),
      _buildSection('Appearance', [
        // Theme toggle, font size, etc.
      ]),
    ],
  ),
)
```

---

## Phase 5: Accessibility

Always include:
- `Semantics` wrapper for custom interactive elements
- `tooltip` on IconButtons
- `semanticLabel` on images
- Sufficient color contrast (4.5:1 minimum for text)
- `Focus` and keyboard navigation support where applicable
- `excludeFromSemantics: true` on decorative images

```dart
// Example: Accessible custom button
Semantics(
  button: true,
  label: 'Add to cart',
  child: GestureDetector(
    onTap: _addToCart,
    child: Container(...),
  ),
)
```

---

## Phase 6: Delivery Checklist

Before delivering the final code, verify:

- [ ] **All colors** come from `Theme.of(context).colorScheme` or a defined constants file
- [ ] **All text styles** come from `Theme.of(context).textTheme` or a defined constants file
- [ ] **Spacing** follows the 4px grid system
- [ ] **Border radius** is consistent across similar components
- [ ] **No overflow errors** — all scrollable content is properly wrapped
- [ ] **Responsive** — works on different screen sizes (at minimum: phone + tablet)
- [ ] **Accessible** — semantic labels, sufficient contrast, proper hit targets
- [ ] **State management** matches complexity (StatefulWidget minimum)
- [ ] **Imports** are correct and necessary
- [ ] **Code compiles** — no syntax errors, all widgets properly nested
- [ ] **Naming** follows Dart conventions (camelCase, PascalCase for classes)

---

## Output Format

### Single Screen

Deliver a single, complete `.dart` file with:
1. All imports at the top
2. The StatefulWidget class
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
2. `app_theme.dart` — `ThemeData` configuration
3. `app_typography.dart` — custom `TextTheme`

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
4. **Ask for clarification** only on critical layout decisions

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

---

## Quality Bar

The generated code should be so clean that:
1. It compiles without errors on first run
2. It looks 90%+ identical to the screenshot
3. A senior Flutter developer would approve it in code review
4. It follows [Effective Dart](https://dart.dev/effective-dart) guidelines
5. It could be shipped to production with minimal modifications
