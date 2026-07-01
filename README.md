# Flutter Screenshot to Code

> Turn any UI screenshot into production-ready Flutter/Dart code.

A specialized AI skill that analyzes mobile and web UI screenshots and generates clean, idiomatic Flutter code with proper widget hierarchy, Material 3 theming, and responsive design.

## What It Does

Give it a screenshot → Get a complete Flutter screen.

```
📸 Screenshot → 🔍 Visual Analysis → 🧩 Widget Mapping → 📦 Production Code
```

### Input
A screenshot of any UI design — mobile app, web app, or design mockup.

### Output
Complete, runnable Flutter/Dart code with:
- Proper widget tree structure
- Material 3 / Cupertino theming
- Responsive layout
- Consistent spacing and typography
- Accessibility annotations

## Features

- **Deep Visual Analysis** — Identifies layout, colors, spacing, typography, and every UI component
- **Flutter-Native Output** — Generates Dart code with real Flutter widgets, not HTML/CSS
- **Material 3 First** — Uses `Theme.of(context)`, `ColorScheme`, and `TextTheme` by default
- **Responsive by Default** — Handles phone, tablet, and desktop layouts
- **Pattern Recognition** — Recognizes common UI patterns (login, dashboard, settings, onboarding, etc.)
- **Component Catalog** — Maps 30+ UI elements to their Flutter widget equivalents
- **Accessibility Built-In** — Includes `Semantics`, tooltips, and contrast-aware colors
- **Production Ready** — Code follows Effective Dart guidelines and is code-review approved

## Installation

### For OpenCode
```bash
npx skills add https://github.com/Reaan06/flutter-screenshot-to-code -g -y
```

### For Claude Code
```bash
npx skills add https://github.com/Reaan06/flutter-screenshot-to-code -g -y
```

### For any AI agent
Copy `SKILL.md` into your agent's skills directory.

## Usage

### Basic Usage

Just show a screenshot and ask:

> "Convert this screenshot to Flutter code"

The skill will:
1. Analyze the screenshot in detail
2. Map visual elements to Flutter widgets
3. Generate complete Dart code
4. Include theming and responsive design

### Advanced Usage

**With theming:**
> "Convert this to Flutter with a custom theme matching these colors: primary #6C63FF, secondary #FF6584"

**Multiple screens:**
> "Convert these 3 screenshots into a Flutter app with navigation"

**Specific state management:**
> "Convert this to Flutter using Riverpod for state management"

**With animations:**
> "Convert this to Flutter and add smooth transitions between states"

## Example

### Input Screenshot
A login screen with:
- Gradient purple-to-blue background
- Centered white card
- Logo at top
- Email and password fields
- "Sign In" button
- "Forgot Password?" link
- "Sign Up" text link

### Generated Output

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Icon(
                        Icons.fitness_center,
                        size: 64,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome Back',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign In button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

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

## Widget Mapping Reference

<details>
<summary>Click to expand full mapping table</summary>

| Visual Element | Flutter Widget |
|---------------|----------------|
| Top bar with title | `AppBar` / `SliverAppBar` |
| Back arrow | `IconButton(icon: Icon(Icons.arrow_back))` |
| Tab bar | `TabBar` + `TabBarView` |
| Card with shadow | `Card(elevation: N)` |
| Rounded image | `ClipRRect` + `Container` / `Image` |
| Text input | `TextField` / `TextFormField` |
| Filled button | `ElevatedButton` |
| Outlined button | `OutlinedButton` |
| Text button | `TextButton` |
| Icon | `Icon(Icons.xxx)` |
| Circular avatar | `CircleAvatar` |
| Divider | `Divider()` |
| Badge | `Badge` / `Stack` + positioned dot |
| FAB | `FloatingActionButton` |
| Switch | `Switch` / `SwitchListTile` |
| Checkbox | `Checkbox` / `CheckboxListTile` |
| Radio | `Radio` / `RadioListTile` |
| Slider | `Slider` |
| Progress | `CircularProgressIndicator` / `LinearProgressIndicator` |
| Chip | `Chip` / `ActionChip` / `FilterChip` |
| Drawer | `Drawer` |
| SnackBar | `SnackBar` |
| Dialog | `AlertDialog` / `Dialog` |
| ListTile | `ListTile` |
| Grid | `GridView.builder` |
| List | `ListView.builder` |
| Nested scroll | `CustomScrollView` + Slivers |
| Bottom nav | `NavigationBar` / `BottomNavigationBar` |
| Page indicator | `SmoothPageIndicator` / custom dots |
| Gradient | `BoxDecoration(gradient: LinearGradient(...))` |
| Blur | `BackdropFilter` + `ImageFilter.blur` |
| SVG | `SvgPicture.asset` (`flutter_svg`) |
| Network image | `CachedNetworkImage` (`cached_network_image`) |

</details>

## Spacing System

| Token | Value | Usage |
|-------|-------|-------|
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

- [ ] Cupertino widget mapping (iOS-style)
- [ ] Animation patterns (shared element, hero, page transitions)
- [ ] Dark mode variant generation
- [ ] More complex layout patterns (staggered grids, waterfalls)
- [ ] State management templates (Riverpod, Bloc, GetX)

## License

MIT — use it however you want. Made with love to help the Flutter community.

## Credits

Based on the [screenshot-to-code](https://github.com/onewave-ai/claude-skills) skill by onewave-ai, adapted and rebuilt for Flutter/Dart.
