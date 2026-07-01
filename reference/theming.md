---
name: theming
description: Complete guide to Flutter theming with Material 3. Covers ColorScheme, TextTheme, component themes, and dynamic theming.
---

# Flutter Theming Deep Dive

Complete reference for theming Flutter apps with Material 3, including ColorScheme, TextTheme, component themes, dark mode, and platform-adaptive theming.

## Material 3 ColorScheme

### Color Roles (29 colors)

The Material 3 ColorScheme has semantic color roles:

| Role | Purpose | Light Default | Dark Default |
|------|---------|---------------|-------------|
| `primary` | Primary brand color | #6750A4 | #D0BCFF |
| `onPrimary` | Text on primary | #FFFFFF | #381E72 |
| `primaryContainer` | Container using primary | #EADDFF | #4F378B |
| `onPrimaryContainer` | Text on primary container | #21005D | #EADDFF |
| `secondary` | Secondary brand | #625B71 | #CCC2DC |
| `onSecondary` | Text on secondary | #FFFFFF | #332D41 |
| `secondaryContainer` | Container using secondary | #E8DEF8 | #4A4458 |
| `onSecondaryContainer` | Text on secondary container | #1D192B | #E8DEF8 |
| `tertiary` | Tertiary accent | #7D5260 | #EFB8C8 |
| `onTertiary` | Text on tertiary | #FFFFFF | #492532 |
| `tertiaryContainer` | Container using tertiary | #FFD8E4 | #633B48 |
| `onTertiaryContainer` | Text on tertiary container | #31111D | #FFD8E4 |
| `error` | Error state | #B3261E | #F2B8B5 |
| `onError` | Text on error | #FFFFFF | #601410 |
| `errorContainer` | Container using error | #F9DEDC | #8C1D18 |
| `onErrorContainer` | Text on error container | #410E0B | #F9DEDC |
| `surface` | Background surface | #FEF7FF | #141218 |
| `onSurface` | Text on surface | #1D1B20 | #E6E0E9 |
| `surfaceVariant` | Surface variant | #E7E0EC | #49454F |
| `onSurfaceVariant` | Text on surface variant | #49454F | #CAC4D0 |
| `outline` | Borders | #79747E | #938F99 |
| `outlineVariant` | Subtle borders | #CAC4D0 | #49454F |
| `shadow` | Drop shadows | #000000 | #000000 |
| `scrim` | Screen overlay | #000000 | #000000 |
| `inverseSurface` | Inverted surface | #322F35 | #E6E0E9 |
| `onInverseSurface` | Text on inverted surface | #F5EFF7 | #313033 |
| `inversePrimary` | Inverted primary | #D0BCFF | #6750A4 |
| `surfaceTint` | Surface tint | #6750A4 | #D0BCFF |
| `surfaceDim` | Dimmer surface | #DED8E1 | #141218 |
| `surfaceBright` | Brighter surface | #FEF7FF | #3B383E |
| `surfaceContainerLowest` | Lowest container | #FFFFFF | #0F0D13 |
| `surfaceContainerLow` | Low container | #F7F2FA | #1D1B20 |
| `surfaceContainer` | Default container | #F3EDF7 | #211F26 |
| `surfaceContainerHigh` | High container | #ECE6F0 | #2B2930 |
| `surfaceContainerHighest` | Highest container | #E6E0E9 | #36343B |

### ColorScheme.fromSeed

```dart
// Generate a full ColorScheme from a single seed color
final colorScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFF6C63FF),
  brightness: Brightness.light,
);

// With custom primary and secondary
final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  primary: Colors.blue,
  secondary: Colors.orange,
);
```

### ColorScheme.fromImageProvider

```dart
// Extract colors from an image (brand logo, etc.)
final colorScheme = await ColorScheme.fromImageProvider(
  provider: AssetImage('assets/brand-logo.png'),
  brightness: Brightness.light,
);
```

---

## TextTheme Typography

### Material 3 Type Scale

| Role | Default Size | Default Weight | Usage |
|------|-------------|---------------|-------|
| `displayLarge` | 57sp | w400 | Hero headlines |
| `displayMedium` | 45sp | w400 | Section headers |
| `displaySmall` | 36sp | w400 | Sub-headers |
| `headlineLarge` | 32sp | w400 | Screen titles |
| `headlineMedium` | 28sp | w400 | Card titles |
| `headlineSmall` | 24sp | w400 | Subsection titles |
| `titleLarge` | 22sp | w400 | AppBar titles |
| `titleMedium` | 16sp | w500 | List titles, tabs |
| `titleSmall` | 14sp | w500 | Small titles |
| `bodyLarge` | 16sp | w400 | Primary body text |
| `bodyMedium` | 14sp | w400 | Default body text |
| `bodySmall` | 12sp | w400 | Captions |
| `labelLarge` | 14sp | w500 | Buttons, chips |
| `labelMedium` | 12sp | w500 | Small labels |
| `labelSmall` | 11sp | w500 | Overlines, badges |

### Custom TextTheme

```dart
TextTheme(
  // Headlines - use for large display text
  displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25),
  displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
  displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400),

  // Headlines - use for section titles
  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),

  // Titles - use for component titles
  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0),
  titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),

  // Body - use for content text
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),

  // Labels - use for buttons, chips, captions
  labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5),
)
```

### Google Fonts Integration

```dart
import 'package:google_fonts/google_fonts.dart';

// In ThemeData
final textTheme = TextTheme(
  displayLarge: GoogleFonts.inter(fontSize: 57, fontWeight: FontWeight.w400),
  headlineLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w500),
  bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
  labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
);

// Mixing fonts
final textTheme = TextTheme(
  displayLarge: GoogleFonts.playfairDisplay(fontSize: 57),
  bodyLarge: GoogleFonts.inter(fontSize: 16),
  labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
);
```

---

## Component Themes

### InputDecorationTheme

```dart
inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorScheme.outline),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorScheme.outline),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorScheme.primary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: colorScheme.error),
  ),
  labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
)
```

### CardTheme

```dart
cardTheme: CardTheme(
  elevation: 0,
  color: colorScheme.surfaceContainer,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
)
```

### ElevatedButtonTheme

```dart
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: textTheme.labelLarge,
  ),
)
```

### TextButtonTheme

```dart
textButtonTheme: TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: colorScheme.primary,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: textTheme.labelLarge,
  ),
)
```

### OutlinedButtonTheme

```dart
outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: colorScheme.primary,
    side: BorderSide(color: colorScheme.outline),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

### AppBarTheme

```dart
appBarTheme: AppBarTheme(
  elevation: 0,
  scrolledUnderElevation: 1,
  backgroundColor: colorScheme.surface,
  foregroundColor: colorScheme.onSurface,
  titleTextStyle: textTheme.titleLarge?.copyWith(
    color: colorScheme.onSurface,
  ),
  centerTitle: true,
)
```

### NavigationBarTheme

```dart
navigationBarTheme: NavigationBarThemeData(
  backgroundColor: colorScheme.surfaceContainer,
  indicatorColor: colorScheme.primaryContainer,
  elevation: 0,
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w500);
    }
    return TextStyle(color: colorScheme.onSurfaceVariant);
  }),
)
```

### BottomSheetTheme

```dart
bottomSheetTheme: BottomSheetThemeData(
  backgroundColor: colorScheme.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  ),
  showDragHandle: true,
  dragHandleColor: colorScheme.onSurfaceVariant.withOpacity(0.4),
)
```

### DialogTheme

```dart
dialogTheme: DialogTheme(
  backgroundColor: colorScheme.surface,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(28),
  ),
  titleTextStyle: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
  contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
)
```

### ChipTheme

```dart
chipTheme: ChipThemeData(
  backgroundColor: colorScheme.surfaceContainerHighest,
  selectedColor: colorScheme.primaryContainer,
  labelStyle: textTheme.labelLarge,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  side: BorderSide.none,
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
)
```

### SwitchTheme

```dart
switchTheme: SwitchThemeData(
  thumbColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return colorScheme.onPrimary;
    }
    return colorScheme.outline;
  }),
  trackColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return colorScheme.primary;
    }
    return colorScheme.surfaceContainerHighest;
  }),
)
```

---

## Complete ThemeData Example

### Light Theme

```dart
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme(colorScheme),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.primaryContainer,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
      ),
    );
  }
}
```

### Dark Theme

```dart
static ThemeData dark(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: _textTheme(colorScheme),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // ... same component themes with dark colorScheme
  );
}
```

### Usage in main.dart

```dart
MaterialApp(
  title: 'My App',
  theme: AppTheme.light(ColorScheme.fromSeed(seedColor: Color(0xFF6C63FF))),
  darkTheme: AppTheme.dark(ColorScheme.fromSeed(
    seedColor: Color(0xFF6C63FF),
    brightness: Brightness.dark,
  )),
  themeMode: ThemeMode.system, // Follow system
)
```

---

## Dark Mode Best Practices

### Color Adjustments

```dart
// Don't use pure white on dark backgrounds — use onSurface with opacity
Text(
  'Hello',
  style: TextStyle(color: colorScheme.onSurface),
)

// Cards should use surfaceContainer variants, not white
Container(
  color: colorScheme.surfaceContainerHighest, // Not Colors.white
)

// Reduce shadow intensity in dark mode
BoxShadow(
  color: Colors.black.withOpacity(
    Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.1,
  ),
  blurRadius: 8,
)
```

### Adaptive Colors

```dart
// Use resolveFrom for platform-adaptive colors
final adaptiveColor = CupertinoColors.systemGrey.resolveFrom(context);

// Or manual check
final isDark = Theme.of(context).brightness == Brightness.dark;
final cardColor = isDark ? colorScheme.surfaceContainerHighest : colorScheme.surface;
```

---

## Dynamic Color (Material You / Android 12+)

```dart
import 'package:dynamic_color/dynamic_color.dart';

MaterialApp(
  builder: (context, child) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final colorScheme = Theme.of(context).brightness == Brightness.light
            ? (lightDynamic ?? ColorScheme.fromSeed(seedColor: Colors.blue))
            : (darkDynamic ?? ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark));

        return MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
          // ...
        );
      },
    );
  },
)
```

---

## App Colors Constants File

```dart
// lib/config/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFF00D9A6);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);
  static const Color info = Color(0xFF2196F3);

  // Neutral palette
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Dark variants
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkBorder = Color(0xFF333333);
  static const Color darkTextPrimary = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);
}
```
