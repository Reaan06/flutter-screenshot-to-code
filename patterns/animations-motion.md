---
name: animations-motion
description: Animation, motion, and transition patterns for Flutter.
---

# Animations & Motion Patterns

## Implicit Animations (No Controller Needed)

### AnimatedContainer
```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _isExpanded ? 300 : 150,
  height: _isExpanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
    borderRadius: BorderRadius.circular(_isSelected ? 20 : 8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(_isSelected ? 0.2 : 0.05),
        blurRadius: _isSelected ? 12 : 4,
        offset: Offset(0, _isSelected ? 4 : 1),
      ),
    ],
  ),
  child: /* ... */,
)
```

### AnimatedOpacity
```dart
AnimatedOpacity(
  opacity: _isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 200),
  child: /* ... */,
)
```

### AnimatedPositioned
```dart
Stack(
  children: [
    AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      top: _isExpanded ? 0 : 100,
      left: _isExpanded ? 0 : 50,
      child: /* ... */,
    ),
  ],
)
```

### AnimatedSwitcher
```dart
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  transitionBuilder: (child, animation) {
    return ScaleTransition(scale: animation, child: child);
  },
  child: _isLiked
      ? Icon(Icons.star, key: const ValueKey('filled'), color: Colors.amber)
      : Icon(Icons.star_border, key: const ValueKey('outline')),
)
```

### AnimatedCrossFade
```dart
AnimatedCrossFade(
  firstChild: Icon(Icons.thumb_up, size: 48),
  secondChild: Icon(Icons.thumb_down, size: 48),
  crossFadeState: _isPositive ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  duration: const Duration(milliseconds: 300),
)
```

### TweenAnimationBuilder (No Controller)
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: _progress),
  duration: const Duration(milliseconds: 800),
  curve: Curves.easeOut,
  builder: (context, value, child) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: 8,
      backgroundColor: Colors.grey.shade200,
    );
  },
)
```

## Hero Animations

```dart
// Source route
Hero(
  tag: 'product-${product.id}',
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(product.image, fit: BoxFit.cover),
  ),
)

// Destination route
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.image, width: double.infinity, fit: BoxFit.cover),
)
```

## Staggered List Animations

```dart
class StaggeredAnimationList extends StatefulWidget {
  const StaggeredAnimationList({super.key});

  @override
  State<StaggeredAnimationList> createState() => _StaggeredAnimationListState();
}

class _StaggeredAnimationListState extends State<StaggeredAnimationList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final start = (index * 0.1).clamp(0.0, 0.9);
        final end = (start + 0.4).clamp(0.0, 1.0);

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
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('Item ${index + 1}'),
                subtitle: Text('Description for item ${index + 1}'),
              ),
            ),
          ),
        );
      },
    );
  }
}
```

## Lottie Animations

```dart
import 'package:lottie/lottie.dart';

// Loading state
Lottie.asset(
  'assets/animations/loading.json',
  width: 200,
  height: 200,
  repeat: true,
)

// Success state
Lottie.asset(
  'assets/animations/success.json',
  width: 150,
  height: 150,
  repeat: false,
)

// From network
Lottie.network(
  'https://example.com/animation.json',
  width: 200,
  height: 200,
)

// With controller for custom playback
class _AnimatedWidget extends StatefulWidget {
  @override
  State<_AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<_AnimatedWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/celebration.json',
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
```

## Page Transition Animation

```dart
// Custom page transition
class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeSlidePageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeInOut));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.05),
                  end: Offset.zero,
                ).drive(CurveTween(curve: Curves.easeOut)),
                child: child,
              ),
            );
          },
        );
}

// Usage
Navigator.push(context, FadeSlidePageRoute(page: const DetailScreen()));
```

## Shimmer Loading Effect

```dart
import 'package:shimmer/shimmer.dart';

Shimmer.fromColors(
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: Column(
    children: List.generate(5, (_) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 120,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    )),
  ),
)
```

## Button Press Animation

```dart
class _PressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _PressableButton({required this.child, required this.onTap});

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
```

## Number Count-Up Animation

```dart
class AnimatedNumber extends StatelessWidget {
  final int value;
  final TextStyle? style;

  const AnimatedNumber({super.key, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: style,
        );
      },
    );
  }
}

// Usage
AnimatedNumber(
  value: 1250,
  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
    fontWeight: FontWeight.bold,
  ),
)
```
