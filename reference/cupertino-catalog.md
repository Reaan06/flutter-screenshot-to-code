---
name: cupertino-catalog
description: Cupertino widget mapping for iOS-style Flutter interfaces. Use when screenshot shows iOS UI or user requests iOS style.
---

# Cupertino Widget Catalog

Complete reference for building iOS-style Flutter interfaces using Cupertino widgets.

## When to Use Cupertino

### Use Cupertino When:
- Screenshot clearly shows iOS UI elements (SF font, large title nav, iOS switches)
- User explicitly requests iOS-style interface
- Building a platform-specific iOS app
- Client/designer specifies Apple HIG compliance
- The screenshot shows iOS system UI (Control Center, Settings, Messages style)

### Use Material When:
- Screenshot shows Android UI
- Cross-platform app (default to Material)
- User doesn't specify platform
- Screenshot is ambiguous (Material is the default)

### Mixed Approach:
- Use Material for overall structure, Cupertino for specific widgets
- Platform-adaptive: `Theme.of(context).platform` to detect

## Cupertino Widgets

### Page Structure

#### CupertinoPageScaffold
```dart
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('Title'),
    leading: CupertinoNavigationBarBackButton(
      previousPageTitle: 'Back',
      onPressed: () => Navigator.pop(context),
    ),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Text('Done'),
      onPressed: () {},
    ),
  ),
  child: SafeArea(
    child: /* content */,
  ),
)
```

#### CupertinoSliverNavigationBar
```dart
CupertinoPageScaffold(
  child: CustomScrollView(
    slivers: [
      CupertinoSliverNavigationBar(
        largeTitle: Text('Large Title'),
        middle: Text('Small Title'),
        leading: CupertinoNavigationBarBackButton(),
        trailing: Icon(CupertinoIcons.share),
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: /* content */,
      ),
    ],
  ),
)
```

### Navigation

#### CupertinoNavigationBar
```dart
CupertinoNavigationBar(
  leading: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.back),
    onPressed: () => Navigator.pop(context),
  ),
  middle: Text('Screen Title'),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.add),
    onPressed: () {},
  ),
  backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
  border: Border(
    bottom: BorderSide(
      color: CupertinoColors.separator.resolveFrom(context),
      width: 0.5,
    ),
  ),
)
```

#### CupertinoLargeTitleNavigationBar
```dart
// Uses large title that collapses on scroll
CupertinoSliverNavigationBar(
  largeTitle: Text('Messages'),
  middle: Text('Messages'),
  // Collapses to middle text on scroll
)
```

### Buttons

#### CupertinoButton Variants
```dart
// Filled (iOS-style solid button)
CupertinoButton.filled(
  onPressed: () {},
  child: Text('Sign In'),
  minWidth: double.infinity, // full width
  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
)

// Plain (text button)
CupertinoButton(
  onPressed: () {},
  child: Text('Cancel'),
  padding: EdgeInsets.zero,
  minSize: 0,
)

// Tinted (light background)
CupertinoButton.tinted(
  onPressed: () {},
  child: Text('Option'),
)

// Gray
CupertinoButton(
  color: CupertinoColors.systemGrey5,
  onPressed: () {},
  child: Text('Gray Button'),
)

// With icon
CupertinoButton.filled(
  onPressed: () {},
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(CupertinoIcons.camera, size: 20),
      SizedBox(width: 8),
      Text('Take Photo'),
    ],
  ),
)
```

### Text Fields

#### CupertinoTextField
```dart
CupertinoTextField(
  placeholder: 'Email',
  prefix: Padding(
    padding: EdgeInsets.only(left: 12),
    child: Icon(CupertinoIcons.mail, size: 20, color: CupertinoColors.systemGrey),
  ),
  suffix: Padding(
    padding: EdgeInsets.only(right: 12),
    child: Icon(CupertinoIcons.clear_circled_solid, size: 20),
  ),
  decoration: BoxDecoration(
    color: CupertinoColors.systemGrey6,
    borderRadius: BorderRadius.circular(10),
  ),
  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  clearButtonMode: OverlayVisibilityMode.editing,
  keyboardType: TextInputType.emailAddress,
)
```

#### CupertinoSearchTextField
```dart
CupertinoSearchTextField(
  placeholder: 'Search',
  prefixIcon: Icon(CupertinoIcons.search, size: 20),
  suffixIcon: Icon(CupertinoIcons.xmark_circle_fill, size: 18),
  decoration: BoxDecoration(
    color: CupertinoColors.systemGrey6,
    borderRadius: BorderRadius.circular(10),
  ),
  onChanged: (value) {},
)
```

### Switches

#### CupertinoSwitch
```dart
CupertinoSwitch(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
  activeColor: CupertinoColors.systemGreen,
  trackColor: CupertinoColors.systemGrey4,
)

// In a list tile
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('Enable notifications'),
    CupertinoSwitch(
      value: _notificationsEnabled,
      onChanged: (v) => setState(() => _notificationsEnabled = v),
    ),
  ],
)
```

### Sliders

#### CupertinoSlider
```dart
CupertinoSlider(
  value: _volume,
  onChanged: (value) => setState(() => _volume = value),
  min: 0,
  max: 100,
  divisions: 10,
  activeColor: CupertinoColors.systemBlue,
  thumbColor: CupertinoColors.white,
)
```

### Segmented Control

#### CupertinoSegmentedControl
```dart
CupertinoSegmentedControl<int>(
  children: {
    0: Text('Day'),
    1: Text('Week'),
    2: Text('Month'),
  },
  groupValue: _selectedPeriod,
  onValueChanged: (value) => setState(() => _selectedPeriod = value),
  padding: EdgeInsets.all(4),
  borderColor: CupertinoColors.systemGrey4,
  selectedColor: CupertinoColors.activeBlue,
  unselectedColor: CupertinoColors.systemBackground,
  pressedColor: CupertinoColors.activeBlue.withOpacity(0.2),
)
```

### Lists

#### CupertinoListSection.insetGrouped
```dart
CupertinoListSection.insetGrouped(
  header: Text('ACCOUNT'),
  children: [
    CupertinoListTile(
      leading: Icon(CupertinoIcons.person_circle, color: CupertinoColors.systemBlue),
      title: Text('Profile'),
      trailing: CupertinoListTileChevron(),
      onTap: () {},
    ),
    CupertinoListTile(
      leading: Icon(CupertinoIcons.bell, color: CupertinoColors.systemOrange),
      title: Text('Notifications'),
      trailing: CupertinoSwitch(
        value: true,
        onChanged: (v) {},
      ),
    ),
    CupertinoListTile(
      leading: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGrey),
      title: Text('Privacy'),
      trailing: CupertinoListTileChevron(),
      onTap: () {},
    ),
  ],
)

// Section without grouping
CupertinoListSection(
  header: Text('SETTINGS'),
  children: [
    CupertinoListTile(
      title: Text('Dark Mode'),
      trailing: CupertinoSwitch(
        value: _isDark,
        onChanged: (v) => setState(() => _isDark = v),
      ),
    ),
  ],
)
```

### Alerts & Sheets

#### CupertinoAlertDialog
```dart
showCupertinoDialog(
  context: context,
  builder: (context) => CupertinoAlertDialog(
    title: Text('Delete Item?'),
    content: Text('This action cannot be undone.'),
    actions: [
      CupertinoDialogAction(
        child: Text('Cancel'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () {
          Navigator.pop(context);
          // Delete
        },
      ),
    ],
  ),
)
```

#### CupertinoActionSheet
```dart
showCupertinoModalPopup(
  context: context,
  builder: (context) => CupertinoActionSheet(
    title: Text('Choose an Action'),
    message: Text('Select one of the options below'),
    actions: [
      CupertinoActionSheetAction(
        child: Text('Take Photo'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoActionSheetAction(
        child: Text('Choose from Library'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoActionSheetAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () => Navigator.pop(context),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('Cancel'),
      isDefaultAction: true,
      onPressed: () => Navigator.pop(context),
    ),
  ),
)
```

#### CupertinoModalBottomSheet
```dart
showCupertinoModalBottomSheet(
  context: context,
  backgroundColor: CupertinoColors.systemBackground,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (context) => CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('Details'),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('Done'),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    child: SafeArea(
      child: /* content */,
    ),
  ),
)
```

### Pickers

#### CupertinoDatePicker
```dart
CupertinoDatePicker(
  initialDateTime: DateTime.now(),
  mode: CupertinoDatePickerMode.date,
  onDateTimeChanged: (dateTime) {},
  minimumYear: 2000,
  maximumYear: 2030,
)

// Date and time
CupertinoDatePicker(
  mode: CupertinoDatePickerMode.dateAndTime,
  onDateTimeChanged: (dateTime) {},
)
```

#### CupertinoTimerPicker
```dart
CupertinoTimerPicker(
  initialTimerDuration: Duration(hours: 1, minutes: 30),
  onTimerDurationChanged: (duration) {},
  mode: CupertinoTimerPickerMode.hms,
)
```

#### CupertinoPicker
```dart
CupertinoPicker(
  scrollController: FixedExtentScrollController(initialItem: 1),
  itemExtent: 32,
  onSelectedItemChanged: (index) {},
  children: [
    Text('Option 1'),
    Text('Option 2'),
    Text('Option 3'),
  ],
)
```

### Loading & Progress

```dart
// Activity indicator (iOS spinner)
CupertinoActivityIndicator()
CupertinoActivityIndicator(animating: true, radius: 16)

// Full-screen loading overlay
Stack(
  children: [
    /* content */,
    if (_isLoading)
      Container(
        color: CupertinoColors.systemGrey.withOpacity(0.3),
        child: Center(
          child: CupertinoActivityIndicator(radius: 20),
        ),
      ),
  ],
)
```

### Scrollbar

```dart
CupertinoScrollbar(
  thumbVisibility: true,
  child: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
  ),
)
```

### Pull to Refresh

```dart
CustomScrollView(
  physics: BouncingScrollPhysics(), // iOS bounce effect
  slivers: [
    CupertinoSliverRefreshControl(
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
      },
    ),
    SliverToBoxAdapter(
      child: /* content */,
    ),
  ],
)
```

## Cupertino Theming

### CupertinoThemeData

```dart
CupertinoTheme(
  data: CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
    barBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      primaryLabel: TextStyle(color: CupertinoColors.activeBlue),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: CupertinoColors.label,
      ),
      navTitleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.label,
      ),
    ),
  ),
  child: MaterialApp(
    // ...
  ),
)
```

### Dark Mode Cupertino

```dart
CupertinoTheme(
  data: CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
    barBackgroundColor: CupertinoColors.darkBackgroundElevated,
    textTheme: CupertinoTextThemeData(
      primaryLabel: TextStyle(color: CupertinoColors.activeBlue),
    ),
  ),
  child: // ...
)
```

### Dynamic Colors (iOS 13+)

```dart
// Use dynamic colors that adapt to wallpaper (iOS)
final dynamicColor = CupertinoDynamicColor.withBrightness(
  color: Colors.white,    // Light
  darkColor: Colors.black, // Dark
);

// Apply
Container(
  color: dynamicColor.resolveFrom(context),
)
```

## Complete Cupertino Screen Example

```dart
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: Text('GENERAL'),
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.person, color: CupertinoColors.systemBlue),
                  title: Text('Account'),
                  trailing: CupertinoListTileChevron(),
                  onTap: () {},
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.bell, color: CupertinoColors.systemOrange),
                  title: Text('Notifications'),
                  trailing: CupertinoSwitch(
                    value: true,
                    onChanged: (v) {},
                  ),
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.lock, color: CupertinoColors.systemGreen),
                  title: Text('Privacy'),
                  trailing: CupertinoListTileChevron(),
                  onTap: () {},
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text('APPEARANCE'),
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.moon, color: CupertinoColors.systemIndigo),
                  title: Text('Dark Mode'),
                  trailing: CupertinoSwitch(
                    value: false,
                    onChanged: (v) {},
                  ),
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.textformat_size, color: CupertinoColors.systemTeal),
                  title: Text('Text Size'),
                  trailing: CupertinoListTileChevron(),
                  onTap: () {},
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text('ABOUT'),
              children: [
                CupertinoListTile(
                  title: Text('Version'),
                  trailing: Text('1.0.0', style: TextStyle(color: CupertinoColors.systemGrey)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
