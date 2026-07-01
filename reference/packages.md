---
name: packages
description: Recommended Flutter packages for common UI needs. Use when generating code that requires third-party functionality.
---

# Recommended Flutter Packages

Curated packages for common Flutter development needs. Use these when generating code from screenshots.

## Installation

Add to `pubspec.yaml`:
```yaml
dependencies:
  package_name: ^version
```

Then run:
```bash
flutter pub get
```

---

## Navigation & Routing

### go_router (Recommended)
**Purpose**: Declarative routing with deep linking support
**When**: Any app with multiple screens and navigation
```yaml
go_router: ^14.0.0
```
```dart
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (_, state) => ProductScreen(id: state.pathParameters['id']!),
    ),
    ShellRoute(
      builder: (_, __, child) => MainScaffold(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => HomeScreen()),
        GoRoute(path: '/profile', builder: (_, __) => ProfileScreen()),
      ],
    ),
  ],
);
```

### auto_route
**Purpose**: Code-generation based routing
**When**: Large apps needing type-safe routes
```yaml
auto_route: ^9.0.0
auto_route_generator: ^9.0.0
```

---

## State Management

### flutter_riverpod (Recommended)
**Purpose**: Compile-safe state management
**When**: Medium to large apps, teams, testable code
```yaml
flutter_riverpod: ^2.5.0
```
```dart
// Provider
final counterProvider = StateProvider<int>((ref) => 0);

// Usage
Consumer(builder: (context, ref, child) {
  final count = ref.watch(counterProvider);
  return Text('$count');
});
```

### flutter_bloc
**Purpose**: Predictable state management with events
**When**: Complex state transitions, team projects, strict architecture
```yaml
flutter_bloc: ^8.1.0
equatable: ^2.0.5
```
```dart
// Cubit
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

// Usage
BlocProvider(
  create: (_) => CounterCubit(),
  child: BlocBuilder<CounterCubit, int>(
    builder: (context, count) => Text('$count'),
  ),
)
```

### provider
**Purpose**: Simple state management
**When**: Small apps, learning, quick prototypes
```yaml
provider: ^6.1.0
```

---

## UI Components

### flutter_svg
**Purpose**: Render SVG images
**When**: Design uses SVG icons/illustrations
```yaml
flutter_svg: ^2.0.0
```
```dart
SvgPicture.asset('assets/icons/logo.svg', width: 48, height: 48)
SvgPicture.network('https://example.com/icon.svg')
```

### cached_network_image
**Purpose**: Cache network images with placeholders
**When**: Displaying images from URLs
```yaml
cached_network_image: ^3.3.0
```
```dart
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
  fit: BoxFit.cover,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### shimmer
**Purpose**: Loading skeleton placeholders
**When**: Show loading states that mimic content layout
```yaml
shimmer: ^3.0.0
```
```dart
Shimmer.fromColors(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: Column(
    children: List.generate(5, (_) => Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(width: 48, height: 48, color: Colors.white),
          SizedBox(width: 16),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 200, height: 16, color: Colors.white),
              SizedBox(height: 8),
              Container(width: 120, height: 12, color: Colors.white),
            ],
          )),
        ],
      ),
    )),
  ),
)
```

### lottie
**Purpose**: Render After Effects animations
**When**: Complex animations, loading states, success states
```yaml
lottie: ^3.1.0
```
```dart
Lottie.asset('assets/animations/loading.json', width: 200)
Lottie.network('https://example.com/animation.json')
```

### rive
**Purpose**: Interactive animations with state machines
**When**: Interactive animated elements, complex motion
```yaml
rive: ^0.13.0
```

### smooth_page_indicator
**Purpose**: Animated page indicators
**When**: PageView onboarding, carousels
```yaml
smooth_page_indicator: ^1.1.0
```
```dart
SmoothPageIndicator(
  controller: _pageController,
  count: 3,
  effect: ExpandingDotsEffect(
    activeDotColor: colorScheme.primary,
    dotColor: colorScheme.onSurfaceVariant.withOpacity(0.3),
  ),
)
```

### badges
**Purpose**: Notification badges
**When**: Show counts on icons
```yaml
badges: ^3.1.0
```
```dart
Badge(
  label: Text('3'),
  child: Icon(Icons.shopping_cart),
)
```

### flutter_staggered_animations
**Purpose**: Staggered list animations
**When**: Animate list items appearing sequentially
```yaml
flutter_staggered_animations: ^1.1.0
```
```dart
AnimationLimiter(
  child: ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return AnimationConfiguration.staggeredList(
        position: index,
        duration: Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(child: ListTile(title: Text('Item $index'))),
        ),
      );
    },
  ),
)
```

---

## Forms

### flutter_form_builder
**Purpose**: Simplified form creation
**When**: Complex forms with many fields
```yaml
flutter_form_builder: ^9.0.0
form_builder_validators: ^9.0.0
```
```dart
FormBuilder(
  key: _formKey,
  child: Column(
    children: [
      FormBuilderTextField(
        name: 'email',
        decoration: InputDecoration(labelText: 'Email'),
        validator: FormBuilderValidators.email(),
      ),
      FormBuilderDropdown(
        name: 'country',
        decoration: InputDecoration(labelText: 'Country'),
        items: ['US', 'UK', 'AR'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      ),
    ],
  ),
)
```

---

## Responsive Design

### responsive_builder
**Purpose**: Simplified responsive breakpoints
**When**: Need phone/tablet/desktop layouts
```yaml
responsive_builder: ^0.7.0
```
```dart
ResponsiveBuilder(
  builder: (context, sizingInformation) {
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      return DesktopLayout();
    } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      return TabletLayout();
    }
    return MobileLayout();
  },
)
```

### flutter_screenutil
**Purpose**: Adapt UI to different screen sizes
**When**: Quick responsive scaling
```yaml
flutter_screenutil: ^5.9.0
```

---

## Theming

### flex_color_scheme
**Purpose**: Advanced Material color schemes
**When**: Need beautiful, customizable color schemes
```yaml
flex_color_scheme: ^8.0.0
```
```dart
FlexThemeData.light(scheme: FlexScheme.mandyRed)
FlexThemeData.dark(scheme: FlexScheme.mandyRed)
```

### google_fonts
**Purpose**: Use Google Fonts in Flutter
**When**: Design uses custom fonts
```yaml
google_fonts: ^6.1.0
```
```dart
Text(
  'Hello',
  style: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)
```

---

## Images & Media

### image_picker
**Purpose**: Pick images from camera/gallery
**When**: User needs to upload photos
```yaml
image_picker: ^1.0.0
```

### photo_view
**Purpose**: Zoomable image viewer
**When**: Full-screen image viewing with pinch-to-zoom
```yaml
photo_view: ^0.15.0
```

### flutter_image_compress
**Purpose**: Compress images before upload
**When**: Reduce image file size
```yaml
flutter_image_compress: ^2.1.0
```

---

## Platform Utilities

### url_launcher
**Purpose**: Open URLs, emails, phone calls
**When**: External links, contact actions
```yaml
url_launcher: ^6.2.0
```
```dart
launchUrl(Uri.parse('https://flutter.dev'));
launchUrl(Uri(scheme: 'tel', path: '+1234567890'));
launchUrl(Uri(scheme: 'mailto', path: 'email@example.com'));
```

### share_plus
**Purpose**: Share content to other apps
**When**: Share buttons
```yaml
share_plus: ^10.0.0
```
```dart
SharePlus.instance.share(ShareParams(text: 'Check this out!', url: Uri.parse('https://example.com')));
```

### path_provider
**Purpose**: Access device file system
**When**: Save files locally
```yaml
path_provider: ^2.1.0
```

### shared_preferences
**Purpose**: Simple key-value local storage
**When**: Save user preferences, flags
```yaml
shared_preferences: ^2.2.0
```
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('onboarding_complete', true);
final complete = prefs.getBool('onboarding_complete') ?? false;
```

### local_auth
**Purpose**: Biometric authentication
**When**: Fingerprint/face ID login
```yaml
local_auth: ^2.1.0
```

---

## Testing

### mocktail
**Purpose**: Mocking for tests
**When**: Unit and widget tests
```yaml
mocktail: ^1.0.0
```
```dart
class MockAuthService extends Mock implements AuthService {}
```

### golden_toolkit
**Purpose**: Golden test utilities
**When**: Visual regression testing
```yaml
golden_toolkit: ^0.15.0
```

### patrol
**Purpose**: Native integration testing
**When**: Test native dialogs, permissions, deep links
```yaml
patrol: ^5.0.0
```

---

## Code Generation

### freezed
**Purpose**: Immutable data classes
**When**: Model classes, state classes
```yaml
freezed: ^2.5.0
json_serializable: ^6.7.0
build_runner: ^2.4.0
```
```dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
  }) = _Product;
}
```

### json_serializable
**Purpose**: JSON serialization
**When**: API data models
```dart
@JsonSerializable()
class User {
  final String name;
  final String email;
  // ...
}
```

---

## Package Selection Guide

| Need | Recommended Package | Alternative |
|------|-------------------|-------------|
| Routing | go_router | auto_route, beamer |
| State (simple) | provider | getx |
| State (medium) | flutter_riverpod | provider |
| State (complex) | flutter_bloc | riverpod |
| Network images | cached_network_image | octo_image |
| SVG | flutter_svg | vector_graphics |
| Animations | lottie | rive |
| Forms | flutter_form_builder | manual Form |
| Responsive | LayoutBuilder (built-in) | responsive_builder |
| Fonts | google_fonts | manual asset |
| Storage | shared_preferences | hive |
| Testing | mocktail + flutter_test | mockito |
| Code gen | freezed + build_runner | manual |
