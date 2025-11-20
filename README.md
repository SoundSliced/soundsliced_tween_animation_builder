# soundsliced_tween_animation_builder

A Flutter package providing a custom `TweenAnimationBuilder` that uses Timer-based animations instead of ticker providers, making it resilient to hot restarts and engine assertions.

## Features

- **Drop-in replacement** for Flutter's `TweenAnimationBuilder`
- **Timer-based animation** that survives hot restarts without engine assertions
- **Auto-repeat support** for continuous animations
- **Animation key** to programmatically restart animations
- **Curve support** for custom easing functions
- **Callback on animation end** for chaining animations

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  soundsliced_tween_animation_builder: ^1.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:soundsliced_tween_animation_builder/soundsliced_tween_animation_builder.dart';
```

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:soundsliced_tween_animation_builder/soundsliced_tween_animation_builder.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: Center(child: Text('Fading In')),
          ),
        );
      },
    );
  }
}
```

### Auto-Repeat Animation

```dart
MyTweenAnimationBuilder<double>(
  tween: Tween<double>(begin: 0.0, end: 360.0),
  duration: Duration(seconds: 2),
  autoRepeat: true,
  builder: (context, value, child) {
    return Transform.rotate(
      angle: value * 3.14159 / 180, // Convert to radians
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Center(child: Text('Spinning')),
      ),
    );
  },
)
```

### Restart Animation with Key

```dart
class RestartableAnimation extends StatefulWidget {
  @override
  _RestartableAnimationState createState() => _RestartableAnimationState();
}

class _RestartableAnimationState extends State<RestartableAnimation> {
  Object? _animationKey;

  void _restartAnimation() {
    setState(() {
      _animationKey = Object(); // New key restarts animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 100.0),
          duration: Duration(seconds: 1),
          animationKey: _animationKey,
          builder: (context, value, child) {
            return Container(
              width: value,
              height: 50,
              color: Colors.green,
            );
          },
        ),
        ElevatedButton(
          onPressed: _restartAnimation,
          child: Text('Restart Animation'),
        ),
      ],
    );
  }
}
```

## API Reference

### MyTweenAnimationBuilder<T>

A widget that animates a value of type `T` using a `Tween`.

#### Constructor Parameters

- `tween`: The `Tween<T>` that defines the animation range
- `duration`: The duration of the animation
- `builder`: A function that builds the widget based on the current animation value
- `curve`: The curve to apply to the animation (default: `Curves.linear`)
- `child`: An optional child widget to pass to the builder
- `onEnd`: Callback function called when the animation completes
- `animationKey`: Key to restart the animation when changed
- `autoRepeat`: Whether to automatically repeat the animation (default: false)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Repository

https://github.com/Soundsliced/soundsliced_tween_animation_builder
