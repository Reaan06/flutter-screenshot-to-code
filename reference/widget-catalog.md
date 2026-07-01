---
name: widget-catalog
description: Complete mapping of visual UI elements to Flutter widgets. Reference for screenshot-to-code conversion.
---

# Flutter Widget Catalog

Complete reference for mapping visual UI elements to Flutter widgets during screenshot-to-code conversion.

## Layout Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Scaffold` | Material screen structure | appBar, body, bottomNavigationBar, drawer, floatingActionButton, backgroundColor |
| `Container` | Box model (size, padding, margin, decoration) | width, height, padding, margin, decoration, child |
| `SizedBox` | Fixed size spacer | width, height, child |
| `Padding` | Inner spacing | padding: EdgeInsets.*, child |
| `Center` | Center child | child |
| `Align` | Position child within parent | alignment: Alignment.*, child |
| `Expanded` | Fill remaining Flex space | flex: 1, child |
| `Flexible` | Share Flex space (shrink if needed) | flex: 1, fit: FlexFit.loose, child |
| `AspectRatio` | Maintain aspect ratio | aspectRatio: 16/9, child |
| `ConstrainedBox` | Apply additional constraints | constraints: BoxConstraints.*, child |
| `UnconstrainedBox` | Remove parent constraints | child |
| `FractionallySizedBox` | Size relative to parent | widthFactor: 0.5, heightFactor: 0.8, child |
| `IntrinsicHeight` | Match tallest child height | child |
| `IntrinsicWidth` | Match widest child width | child |
| `LayoutBuilder` | Build based on parent constraints | builder: (context, constraints) => Widget |
| `OrientationBuilder` | Build based on orientation | builder: (context, orientation) => Widget |

## Flex Layout

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Row` | Horizontal layout | mainAxisAlignment, crossAxisAlignment, children |
| `Column` | Vertical layout | mainAxisAlignment, crossAxisAlignment, children |
| `Flex` | Configurable direction | direction: Axis.horizontal/vertical, children |

### MainAxisAlignment Values
- `start` — Left/top
- `end` — Right/bottom
- `center` — Center
- `spaceBetween` — Even spacing, no edges
- `spaceAround` — Even spacing, half at edges
- `spaceEvenly` — Even spacing, equal at edges

### CrossAxisAlignment Values
- `start` — Left/top
- `end` — Right/bottom
- `center` — Center
- `stretch` — Fill cross axis
- `baseline` — Align by text baseline

## Stack Layout

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Stack` | Overlapping children | alignment, fit, children |
| `Positioned` | Position child in Stack | top, bottom, left, right, width, height |
| `IndexedStack` | Show one child at a time | index, children |

## Scrollable Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `SingleChildScrollView` | Scroll single child | scrollDirection, padding, child |
| `ListView` | Vertical scrollable list | children, padding, itemExtent |
| `ListView.builder` | Lazy vertical list | itemCount, itemBuilder, prototypeItem |
| `ListView.separated` | List with separators | itemCount, itemBuilder, separatorBuilder |
| `GridView` | Scrollable grid | gridDelegate, children, padding |
| `GridView.builder` | Lazy grid | gridDelegate, itemCount, itemBuilder |
| `CustomScrollView` | Mixed sliver content | slivers |
| `NestedScrollView` | Nested scroll areas | headerSliverBuilder, body |
| `PageView` | Swipeable pages | controller, onPageChanged, children, scrollDirection |
| `PageView.builder` | Lazy swipeable pages | itemCount, itemBuilder, controller |
| `ReorderableListView` | Drag-to-reorder list | onReorder, children |
| `TwoDimensionalScrollView` | 2D scrolling | diagonalDragBehavior |

## Sliver Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `SliverList` | Lazy list in CustomScrollView | delegate: SliverChildBuilderDelegate |
| `SliverGrid` | Grid in CustomScrollView | delegate, gridDelegate |
| `SliverToBoxAdapter` | Non-sliver child in CustomScrollView | child |
| `SliverAppBar` | Collapsing app bar | expandedHeight, floating, pinned, snap, flexibleSpace |
| `SliverPersistentHeader` | Persistent header | delegate |
| `SliverFillRemaining` | Fill remaining space | child |
| `SliverPadding` | Padding for slivers | padding, sliver |
| `SliverOpacity` | Opacity for slivers | opacity, sliver |
| `SliverIgnorePointer` | Ignore touches on slivers | sliver |
| `SliverAnimatedList` | Animated list in CustomScrollView | itemBuilder, initialItemCount |

## Grid Layout

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `GridView.count` | Fixed column count grid | crossAxisCount, children |
| `GridView.extent` | Max extent grid | maxCrossAxisExtent, children |
| `GridView.builder` | Lazy grid | gridDelegate, itemBuilder, itemCount |
| `Wrap` | Flow layout (non-scrollable) | spacing, runSpacing, children |
| `Flow` | Custom flow layout | delegate, children |
| `StaggeredGrid` (flutter_staggered_grid_view) | Pinterest-style grid | crossAxisCount, mainAxisSpacing, crossAxisSpacing |

## Navigation Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `AppBar` | Top app bar | title, leading, actions, bottom, elevation, backgroundColor |
| `SliverAppBar` | Collapsing top bar | expandedHeight, floating, pinned, snap |
| `BottomAppBar` | Bottom bar | child, shape, notchMargin, color |
| `NavigationBar` | Material 3 bottom nav | selectedIndex, onDestinationSelected, destinations |
| `BottomNavigationBar` | Legacy bottom nav | currentIndex, onTap, items, type |
| `NavigationRail` | Side navigation (tablet) | selectedIndex, onDestinationSelected, destinations, labelType |
| `NavigationDrawer` | Side drawer (Material 3) | selectedIndex, onDestinationSelected, children |
| `Drawer` | Material drawer | child, elevation, width |
| `TabBar` | Top tab bar | tabs, controller, isScrollable, labelColor |
| `TabBarView` | Tab content | controller, children |
| `BottomNavigationBarItem` | Tab item | icon, label, activeIcon |
| `NavigationDestination` | Nav bar item | icon, selectedIcon, label |

## Button Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `ElevatedButton` | Filled button with elevation | onPressed, style, child |
| `TextButton` | Text-only button | onPressed, style, child |
| `OutlinedButton` | Border-only button | onPressed, style, child |
| `IconButton` | Icon-only button | icon, onPressed, tooltip, style |
| `FloatingActionButton` | Floating action button | onPressed, child, backgroundColor, shape, mini |
| `FloatingActionButton.extended` | Extended FAB | onPressed, icon, label, backgroundColor |
| `PopupMenuButton` | Overflow menu | onSelected, itemBuilder, icon |
| `DropdownButton` | Dropdown selection | value, items, onChanged, underline |
| `SegmentedButton` | Toggle button group | segments, selected, onSelectionChanged |
| `CloseButton` | System close button | onPressed |
| `BackButton` | System back button | onPressed |

### Button Styles

```dart
// ElevatedButton with custom style
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: textTheme.labelLarge,
  ),
  child: Text('Button'),
)

// Full-width button
SizedBox(
  width: double.infinity,
  height: 48,
  child: ElevatedButton(onPressed: () {}, child: Text('Full Width')),
)
```

## Input Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `TextField` | Text input | controller, decoration, keyboardType, obscureText |
| `TextFormField` | Text input with Form integration | validator, decoration, keyboardType |
| `Checkbox` | Checkbox toggle | value, onChanged, activeColor |
| `CheckboxListTile` | Checkbox with label | value, onChanged, title, subtitle |
| `Radio` | Radio button | value, groupValue, onChanged |
| `RadioListTile` | Radio with label | value, groupValue, onChanged, title, subtitle |
| `Switch` | Toggle switch | value, onChanged, activeColor |
| `SwitchListTile` | Switch with label | value, onChanged, title, subtitle |
| `Slider` | Value slider | value, onChanged, min, max, divisions |
| `RangeSlider` | Range slider | values, onChanged, min, max, divisions |

### InputDecoration Variants

```dart
// Standard outlined
InputDecoration(
  labelText: 'Email',
  hintText: 'you@example.com',
  prefixIcon: Icon(Icons.email_outlined),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
)

// Filled
InputDecoration(
  labelText: 'Search',
  prefixIcon: Icon(Icons.search),
  filled: true,
  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide.none,
  ),
)

// With error
InputDecoration(
  labelText: 'Password',
  errorText: 'Password too short',
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: colorScheme.error),
  ),
)

// With suffix
InputDecoration(
  labelText: 'Password',
  suffixIcon: IconButton(
    icon: Icon(Icons.visibility),
    onPressed: () {},
  ),
)
```

## Display Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Text` | Display text | style: textTheme.*, textAlign, maxLines, overflow |
| `RichText` | Styled text spans | text: TextSpan(children: [...]) |
| `Icon` | Material icon | icon: Icon(Icons.xxx), size, color |
| `Image.asset` | Local image | assetPath, width, height, fit, cacheWidth |
| `Image.network` | Network image | url, width, height, fit, loadingBuilder |
| `CircularProgressIndicator` | Loading spinner | value, strokeWidth, color, backgroundColor |
| `LinearProgressIndicator` | Loading bar | value, color, backgroundColor, minHeight |
| `CircularAvatar` | Circle with image/icon | radius, backgroundImage, child, backgroundColor |
| `CircleAvatar` (NetworkImage) | Profile picture | backgroundImage: NetworkImage(url) |
| `Badge` | Notification badge | label, backgroundColor, textColor, child |
| `Tooltip` | Hover/long-press tooltip | message, child |
| `Divider` | Horizontal line | height, thickness, color, indent, endIndent |
| `VerticalDivider` | Vertical line | width, thickness, color |
| `Spacer` | Flexible space filler | flex: 1 |
| `Placeholder` | Placeholder box | fallbackHeight, fallbackWidth, color |

### Image Fit Values
- `BoxFit.contain` — Fit within bounds, maintain aspect ratio
- `BoxFit.cover` — Fill bounds, crop overflow
- `BoxFit.fill` — Stretch to fill (distort)
- `BoxFit.fitWidth` — Fit width, crop height
- `BoxFit.fitHeight` — Fit height, crop width
- `BoxFit.none` — No fitting
- `BoxFit.scaleDown` — Scale down only

### Text Styles

```dart
// Using textTheme
Text(
  'Headline',
  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
    fontWeight: FontWeight.bold,
  ),
)

// Custom style
Text(
  'Body text',
  style: TextStyle(
    fontSize: 16,
    height: 1.5,
    color: colorScheme.onSurface,
    letterSpacing: 0.5,
  ),
)

// Rich text with spans
RichText(
  text: TextSpan(
    text: 'Hello ',
    style: textTheme.bodyLarge,
    children: [
      TextSpan(
        text: 'World',
        style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
      ),
    ],
  ),
)
```

## Card & Container Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Card` | Elevated card | elevation, shape, color, margin, child |
| `ClipRRect` | Rounded corners | borderRadius, child |
| `ClipOval` | Circular clip | child |
| `ClipPath` | Custom clip shape | clipper, child |
| `DecoratedBox` | Box decoration | decoration: BoxDecoration(...), child |
| `PhysicalModel` | Material with elevation | color, elevation, shape, shadowColor |
| `Material` | Material design surface | type, elevation, color, child |
| `InkWell` | Material ripple tap | onTap, onLongPress, borderRadius, child |
| `InkResponse` | Material ripple (more flexible) | onTap, splashFactory, child |
| `GestureDetector` | Generic gesture handling | onTap, onPan, onScale, child |
| `Hero` | Shared element transition | tag, child, flightShuttleBuilder |
| `Opacity` | Transparency | opacity: 0.0-1.0, child |
| `Transform` | Transformations | transform, alignment, child |
| `BackdropFilter` | Blur/overlay effect | filter: ImageFilter.blur(sigmaX, sigmaY), child |

### BoxDecoration

```dart
BoxDecoration(
  // Color
  color: colorScheme.surface,
  
  // Border radius
  borderRadius: BorderRadius.circular(16),
  
  // Border
  border: Border.all(
    color: colorScheme.outline,
    width: 1,
  ),
  
  // Shadow
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
  
  // Gradient
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [colorScheme.primary, colorScheme.secondary],
  ),
  
  // Image
  image: DecorationImage(
    image: AssetImage('assets/pattern.png'),
    fit: BoxFit.cover,
    opacity: 0.1,
  ),
)
```

## Feedback Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `SnackBar` | Bottom notification | content, action, duration, behavior, backgroundColor |
| `SnackBar` with `SnackBarController` | Managed snackbar | scaffoldMessengerKey |
| `AlertDialog` | Modal dialog | title, content, actions, shape |
| `SimpleDialog` | Simple choice dialog | title, children |
| `Dialog` | Custom dialog | child, backgroundColor, elevation |
| `BottomSheet` | Bottom panel | builder, backgroundColor, shape |
| `showModalBottomSheet` | Modal bottom panel | builder, isScrollControlled, backgroundColor |
| `DraggableScrollableSheet` | Expandable bottom sheet | initialChildSize, minChildSize, maxChildSize, builder |
| `ExpansionTile` | Collapsible section | title, children, initiallyExpanded, leading |
| `Stepper` | Step-by-step flow | steps, currentStep, onStepContinue, onStepCancel |
| `RefreshIndicator` | Pull to refresh | onRefresh, child, color |

### SnackBar Usage

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Item saved successfully'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {},
    ),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(16),
  ),
);
```

### Dialog Usage

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Delete item?'),
    content: Text('This action cannot be undone.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      FilledButton(
        onPressed: () {
          Navigator.pop(context);
          // Delete
        },
        child: Text('Delete'),
      ),
    ],
  ),
);
```

### Bottom Sheet Usage

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => DraggableScrollableSheet(
    initialChildSize: 0.6,
    minChildSize: 0.2,
    maxChildSize: 0.9,
    builder: (context, scrollController) => Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView(
        controller: scrollController,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Content
        ],
      ),
    ),
  ),
)
```

## Selection Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Chip` | Tag/label | label, avatar, deleteIcon, onDeleted, color |
| `ActionChip` | Action tag | label, avatar, onPressed |
| `FilterChip` | Toggleable tag | label, selected, onSelected |
| `ChoiceChip` | Single selection tag | label, selected, onSelected |
| `DataTable` | Table display | columns, rows, headingRowHeight |
| `CalendarDatePicker` | Calendar picker | initialDate, firstDate, lastDate, onDateSelected |
| `DateRangePicker` | Date range picker | initialDateRange, firstDate, lastDate |
| `CupertinoDatePicker` | iOS-style date picker | mode, onDateTimeChanged |
| `CupertinoTimerPicker` | iOS-style time picker | mode, onTimerDurationChanged |

### Chip Variants

```dart
// Basic chip
Chip(
  avatar: CircleAvatar(child: Text('A')),
  label: Text('Label'),
  deleteIcon: Icon(Icons.close, size: 18),
  onDeleted: () {},
  backgroundColor: colorScheme.surfaceContainerHighest,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
)

// Filter chip
FilterChip(
  label: Text('Option 1'),
  selected: _isSelected,
  onSelected: (selected) => setState(() => _isSelected = selected),
  checkmarkColor: colorScheme.onPrimary,
  selectedColor: colorScheme.primary,
)

// Action chip
ActionChip(
  label: Text('Send'),
  avatar: Icon(Icons.send, size: 18),
  onPressed: _send,
)
```

## Animation Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `AnimatedContainer` | Animate container changes | duration, curve, width/height/color/decoration |
| `AnimatedOpacity` | Animate opacity | opacity, duration, curve |
| `AnimatedPositioned` | Animate position in Stack | top/bottom/left/right, duration, curve |
| `AnimatedSize` | Animate size changes | duration, curve, alignment |
| `AnimatedSwitcher` | Cross-fade children | duration, transitionBuilder, child |
| `AnimatedCrossFade` | Cross-fade between two children | firstChild, secondChild, crossFadeState, duration |
| `AnimatedDefaultTextStyle` | Animate text style changes | style, duration, curve, child |
| `AnimatedPadding` | Animate padding | padding, duration, curve, child |
| `AnimatedAlign` | Animate alignment | alignment, duration, curve, child |
| `AnimatedRotation` | Animate rotation | turns, duration, curve, child |
| `AnimatedScale` | Animate scale | scale, duration, curve, child |
| `FadeTransition` | Fade with AnimationController | opacity, child |
| `SlideTransition` | Slide with AnimationController | position, child |
| `ScaleTransition` | Scale with AnimationController | scale, child |
| `RotationTransition` | Rotate with AnimationController | turns, child |
| `SizeTransition` | Size with AnimationController | sizeFactor, axisAlignment, child |
| `DecoratedBoxTransition` | Animate decoration | decoration, child |
| `RelativePositionedTransition` | Animate relative position | rect, size, child |
| `AnimatedWidget` | Base class for animated widgets | listenable |
| `TweenAnimationBuilder` | Implicit animation builder | tween, duration, curve, builder, child |

### TweenAnimationBuilder (No Controller Needed)

```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeOut,
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 50 * (1 - value)),
        child: child,
      ),
    );
  },
  child: const Text('Animated in!'),
)
```

## Accessibility Widgets

| Widget | Purpose | Key Properties |
|--------|---------|---------------|
| `Semantics` | Screen reader labels | label, button, enabled, selected, child |
| `ExcludeSemantics` | Hide from screen reader | excluding, child |
| `MergeSemantics` | Merge child semantics | child |
| `Tooltip` | Hover/long-press tooltip | message, child, waitDuration |

```dart
// Accessible button
Semantics(
  button: true,
  enabled: true,
  label: 'Add to favorites',
  child: IconButton(
    icon: Icon(_isFavorited ? Icons.star : Icons.star_border),
    onPressed: _toggleFavorite,
    tooltip: 'Add to favorites',
  ),
)

// Decorative image (skip for screen readers)
Image.asset(
  'assets/decorative_pattern.png',
  excludeFromSemantics: true,
)
```

## Platform-Adaptive Widgets

| Widget | Material | Cupertino |
|--------|----------|-----------|
| Page scaffold | `Scaffold` | `CupertinoPageScaffold` |
| Navigation bar | `AppBar` | `CupertinoNavigationBar` |
| Button | `ElevatedButton` | `CupertinoButton` |
| Text field | `TextField` | `CupertinoTextField` |
| Switch | `Switch` | `CupertinoSwitch` |
| Slider | `Slider` | `CupertinoSlider` |
| Action sheet | `BottomSheet` | `CupertinoActionSheet` |
| Alert dialog | `AlertDialog` | `CupertinoAlertDialog` |
| Date picker | `showDatePicker` | `CupertinoDatePicker` |
| Time picker | `showTimePicker` | `CupertinoTimerPicker` |
| Segment control | `SegmentedButton` | `CupertinoSegmentedControl` |
| Search | `TextField` in AppBar | `CupertinoSearchTextField` |
| Tab bar | `TabBar` | `CupertinoTabBar` |
| Progress | `CircularProgressIndicator` | `CupertinoActivityIndicator` |
| Pull refresh | `RefreshIndicator` | `CupertinoSliverRefreshControl` |
| List section | `ListView` | `CupertinoListSection.insetGrouped` |
| Scrollbar | `Scrollbar` | `CupertinoScrollbar` |
| Page transition | Slide from bottom | Slide from right (Cupertino) |
