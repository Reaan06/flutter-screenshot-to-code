# Flutter Screenshot to Code

> Turn any UI screenshot into production-ready Flutter/Dart code.

A comprehensive AI skill (7,900+ lines) that analyzes mobile and web UI screenshots and generates clean, idiomatic Flutter code with proper widget hierarchy, Material 3 / Cupertino theming, responsive design, state management, animations, and accessibility.

## What It Does

```
📸 Screenshot → 🔍 Visual Analysis → 🧩 Widget Mapping → 📦 Production Code
```

### Input
A screenshot of any UI design — mobile app, web app, or design mockup (iOS or Android).

### Output
Complete, runnable Flutter/Dart code with:
- Proper widget tree structure
- Material 3 **and** Cupertino theming (auto-detects platform)
- Responsive layout (phone / tablet / desktop)
- State management (StatefulWidget, Provider, Riverpod, BLoC)
- Animations and micro-interactions
- Dark mode support
- Accessibility annotations
- Widget tests

## Installation

```bash
npx skills add Reaan06/flutter-screenshot-to-code --all
```

That's it. One command. Automatically installs to all your AI agents (Claude Code, OpenCode, Codex, Gemini CLI, and more).

### Update
```bash
npx skills update flutter-screenshot-to-code
```

## Features

- **Deep Visual Analysis** — Identifies layout, colors, spacing, typography, and every UI component
- **Flutter-Native Output** — Generates Dart code with real Flutter widgets, not HTML/CSS
- **Platform Detection** — Automatically uses Material or Cupertino based on the screenshot
- **Material 3 + Cupertino** — Full support for both design systems
- **30+ Component Mappings** — Every visual element mapped to its Flutter widget
- **8 Common Patterns** — Login, Dashboard, Settings, Onboarding, Forms, Navigation, Animations, and more
- **State Management** — Templates for Provider, Riverpod, BLoC/Cubit
- **Responsive Design** — Phone, tablet, and desktop layouts with breakpoints
- **Dark Mode** — Complete theming for light and dark modes
- **Accessibility** — Semantics, tooltips, contrast, hit targets
- **Testing** — Widget test patterns and golden test setup
- **Performance** — const constructors, ListView.builder, image optimization

## Usage

### Basic
> "Convert this screenshot to Flutter code"

### With Theming
> "Convert this to Flutter with a custom theme: primary #6C63FF, secondary #FF6584"

### Multiple Screens
> "Convert these 3 screenshots into a Flutter app with navigation"

### With State Management
> "Convert this to Flutter using Riverpod for state management"

### iOS Style
> "Convert this to Flutter with Cupertino widgets (iOS style)"

### With Animations
> "Convert this to Flutter and add smooth transitions between states"

## File Structure

```
flutter-screenshot-to-code/
├── SKILL.md                          # Main skill (entry point)
├── README.md                         # This file
├── LICENSE                           # MIT
├── reference/
│   ├── widget-catalog.md             # 30+ widget mappings (Material + Cupertino)
│   ├── cupertino-catalog.md          # Complete Cupertino widget guide
│   ├── packages.md                   # 40+ recommended packages
│   └── theming.md                    # Material 3 theming deep dive
├── patterns/
│   ├── login-auth.md                 # Login, signup, OTP, forgot password
│   ├── dashboard-home.md             # Dashboard, feeds, stats cards
│   ├── settings-preferences.md       # Settings, profile edit
│   ├── onboarding-pageview.md        # Onboarding, carousels
│   ├── forms-validation.md           # Forms, inputs, validation
│   ├── navigation-routing.md         # GoRouter, transitions, deep links
│   └── animations-motion.md          # Implicit, Hero, staggered, Lottie
└── templates/
    ├── state-management.md           # Riverpod, BLoC, Provider
    ├── testing.md                    # Widget tests, golden tests
    └── responsive.md                 # Breakpoints, adaptive layouts
```

## What's Inside

### Reference Guides
- **Widget Catalog** — 30+ components mapped with code examples (Material + Cupertino)
- **Cupertino Catalog** — Full iOS widget guide (CupertinoNavigationBar, CupertinoButton, etc.)
- **Packages** — 40+ recommended packages by category with usage examples
- **Theming** — Complete Material 3 ColorScheme, TextTheme, component themes

### Code Patterns (7 patterns)
- **Login/Auth** — Gradient backgrounds, forms, validation, social login, OTP
- **Dashboard** — Stats cards, feeds, quick actions, empty states, shimmer loading
- **Settings** — Sections, toggles, navigation, danger zone
- **Onboarding** — PageView, animated indicators, skip/next/done
- **Forms** — Multi-field validation, input formatters, chip selection, date pickers
- **Navigation** — GoRouter, page transitions, auth guards, deep linking
- **Animations** — Implicit, Hero, staggered, Lottie, shimmer, micro-interactions

### Implementation Templates
- **State Management** — StatefulWidget, Provider, Riverpod, BLoC with complete examples
- **Testing** — Widget tests, golden tests, integration tests, mock patterns
- **Responsive** — Breakpoints, adaptive navigation, responsive grid/form/dashboard

## Supported UI Patterns

| Pattern | Widgets Used |
|---------|-------------|
| Login / Auth | `Container` (gradient) + `Card` + `TextField` + `ElevatedButton` |
| Dashboard | `Scaffold` + `ListView` + `Card` + `Row/Column` |
| Detail / Profile | `CustomScrollView` + `SliverAppBar` + `SliverToBoxAdapter` |
| Settings | `ListView` + `SwitchListTile` + `ListTile` |
| Onboarding | `PageView` + `Stack` + animated indicators |
| Bottom Navigation | `NavigationBar` + `IndexedStack` |
| Form | `Form` + `GlobalKey<FormState>` + `TextFormField` |
| List + Search | `AppBar` (with search) + `ListView.builder` |
| Grid | `GridView.builder` + `SliverGridDelegateWithFixedCrossAxisCount` |
| Modal / Bottom Sheet | `showModalBottomSheet` + `DraggableScrollableSheet` |

## Platform Support

| Platform | Widgets |
|----------|---------|
| Android (Material) | `Scaffold`, `AppBar`, `NavigationBar`, `Card`, `ElevatedButton`, etc. |
| iOS (Cupertino) | `CupertinoPageScaffold`, `CupertinoNavigationBar`, `CupertinoButton`, etc. |
| Web | Responsive layouts, keyboard support |
| Desktop | Navigation drawer, wide layouts, hover states |

## Spacing System

| Token | Value | Usage |
|-------|-------|-------|
| xxs | 2px | Micro spacing (icon to text) |
| xs | 4px | Tight inner spacing |
| sm | 8px | Default inner spacing |
| md | 12px | Between related items |
| lg | 16px | Standard padding |
| xl | 24px | Section separation |
| 2xl | 32px | Major section breaks |
| 3xl | 48px | Screen-level spacing |

## Tips for Best Results

1. **High-quality screenshots** — The clearer the image, the better the output
2. **Full screens preferred** — Complete screens give better context than cropped sections
3. **Mention your stack** — Tell the agent if you use Provider, Riverpod, Bloc, etc.
4. **Specify platform** — iOS (Cupertino) or Android (Material) affects widget choice
5. **Include design tokens** — If you have a color palette or font specs, share them

## Contributing

Contributions welcome! Areas where help is needed:

- [ ] More Cupertino widget patterns
- [ ] Animation blueprints (complex sequences)
- [ ] More state management templates (GetX, Signals)
- [ ] Internationalization (i18n) patterns
- [ ] Accessibility advanced patterns
- [ ] Performance optimization guide

## License

MIT — use it however you want. Made with love to help the Flutter community.

## Credits

Based on the [screenshot-to-code](https://github.com/onewave-ai/claude-skills) skill by onewave-ai, completely rebuilt for Flutter/Dart.
