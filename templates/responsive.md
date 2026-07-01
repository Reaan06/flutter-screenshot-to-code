---
name: responsive
description: Responsive design patterns and templates for Flutter. Covers phone, tablet, desktop, and adaptive layouts.
---

# Responsive Design Templates

## Breakpoints

```dart
class Breakpoints {
  Breakpoints._();

  static const double phone = 600;
  static const double tablet = 1024;
  static const double desktop = 1200;
  static const double largeDesktop = 1440;

  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phone;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= phone && width < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;
}
```

## Responsive Padding

```dart
EdgeInsets responsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return const EdgeInsets.all(16);
  if (width < 1024) return const EdgeInsets.all(32);
  return const EdgeInsets.symmetric(horizontal: 48, vertical: 32);
}
```

## Responsive Grid

```dart
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 2 : width < 1024 ? 3 : 4;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
```

## Responsive Dashboard (Phone / Tablet / Desktop)

```dart
class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return _DesktopLayout();
    } else if (width >= 600) {
      return _TabletLayout();
    } else {
      return _PhoneLayout();
    }
  }
}

class _PhoneLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats row
          Row(
            children: [
              Expanded(child: _StatCard(title: 'Users', value: '1,234')),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(title: 'Revenue', value: '\$12,345')),
            ],
          ),
          const SizedBox(height: 16),
          // Content
          _ContentSection(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'Analytics'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation rail
          NavigationRail(
            selectedIndex: 0,
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.analytics), label: Text('Analytics')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          const VerticalDivider(width: 1),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    Expanded(child: _StatCard(title: 'Users', value: '1,234')),
                    const SizedBox(width: 16),
                    Expanded(child: _StatCard(title: 'Revenue', value: '\$12,345')),
                    const SizedBox(width: 16),
                    Expanded(child: _StatCard(title: 'Orders', value: '567')),
                  ],
                ),
                const SizedBox(height: 24),
                _ContentSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Permanent drawer
          SizedBox(
            width: 260,
            child: NavigationDrawer(
              selectedIndex: 0,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text('My App',
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: const Text('Home'),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.analytics_outlined),
                  selectedIcon: const Icon(Icons.analytics),
                  label: const Text('Analytics'),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(32),
              children: [
                Row(
                  children: [
                    Expanded(child: _StatCard(title: 'Users', value: '1,234')),
                    const SizedBox(width: 24),
                    Expanded(child: _StatCard(title: 'Revenue', value: '\$12,345')),
                    const SizedBox(width: 24),
                    Expanded(child: _StatCard(title: 'Orders', value: '567')),
                    const SizedBox(width: 24),
                    Expanded(child: _StatCard(title: 'Growth', value: '+23%')),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _ContentSection()),
                    const SizedBox(width: 24),
                    Expanded(child: _SidebarSection()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )),
          ],
        ),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Content', style: Theme.of(context).textTheme.titleLarge),
      ]),
    ));
  }
}

class _SidebarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Sidebar', style: Theme.of(context).textTheme.titleLarge),
      ]),
    ));
  }
}
```

## Adaptive Navigation

```dart
class AdaptiveNavigation extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const AdaptiveNavigation({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return Scaffold(
        body: Row(
          children: [
            NavigationDrawer(
              selectedIndex: currentIndex,
              children: const [
                NavigationDrawerDestination(icon: Icon(Icons.home), label: Text('Home')),
                NavigationDrawerDestination(icon: Icon(Icons.search), label: Text('Search')),
                NavigationDrawerDestination(icon: Icon(Icons.person), label: Text('Profile')),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    if (width >= 600) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

## Responsive Form

```dart
class ResponsiveForm extends StatelessWidget {
  const ResponsiveForm({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 800 : double.infinity),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildBasicInfo(context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildAdditionalInfo(context)),
                  ],
                )
              else
                Column(
                  children: [
                    _buildBasicInfo(context),
                    const SizedBox(height: 16),
                    _buildAdditionalInfo(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Info', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Name')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Additional Info', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Address')),
          ],
        ),
      ),
    );
  }
}
```

## Platform Detection

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';

// Check platform
bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isIOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

// Adaptive widget based on platform
Widget buildPlatformButton(VoidCallback onPressed, String label) {
  if (isIOS) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      child: Text(label),
    );
  }
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(label),
  );
}
```
