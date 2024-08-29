import 'dart:async';
import 'dart:ui';

/// A utility class that delays the execution of a callback function.
///
/// This class is useful for implementing debouncing behavior, where
/// a function is called only after a certain period of inactivity.
/// For instance, this can be used to delay actions such as search queries
/// or other functions that should not be triggered too frequently.
class Delayer {
  /// The duration in milliseconds to delay the execution of the callback.
  final int milliseconds;

  /// The callback function to be executed after the delay.
  VoidCallback? action;

  Timer? _timer;

  /// Creates a [Delayer] with the specified delay duration.
  ///
  /// The [milliseconds] parameter defines how long to wait before executing
  /// the callback function.
  Delayer({required this.milliseconds});

  /// Schedules the [action] to be executed after the specified delay.
  ///
  /// If a previous action was scheduled, it will be canceled and replaced
  /// with the new one. This ensures that the action is only executed once
  /// after the specified delay, regardless of how many times this method
  /// is called.
  ///
  /// [action] The callback function to be executed after the delay.
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
