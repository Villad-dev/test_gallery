import 'package:flutter/material.dart';

/// A widget that displays a loading animation.
///
/// The [LoadingAnimation] widget uses a [SlideTransition] to animate a
/// [CircularProgressIndicator] onto the screen. It is shown only when the
/// [isLoading] parameter is true.
class LoadingAnimation extends StatelessWidget {
  /// Indicates whether the loading animation should be displayed.
  final bool isLoading;

  /// The animation that controls the slide transition of the loading animation.
  final Animation<Offset> animation;

  /// Creates a [LoadingAnimation] widget.
  ///
  /// The [isLoading] and [animation] parameters are required.
  const LoadingAnimation({
    super.key,
    required this.isLoading,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    // If not loading, return an empty widget.
    if (!isLoading) return const SizedBox.shrink();

    return SlideTransition(
      position: animation,
      child: const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            strokeWidth: 10,
            strokeCap: StrokeCap.round,
            valueColor: AlwaysStoppedAnimation(Colors.orange),
          ),
        ),
      ),
    );
  }
}
