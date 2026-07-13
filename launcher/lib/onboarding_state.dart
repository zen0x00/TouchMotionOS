import 'dart:io';

/// Persistent one-shot onboarding flag.
///
/// A marker file in the user's data directory records that onboarding has
/// been completed. Fresh install has no file, so onboarding shows once;
/// completing it writes the file and every later boot goes straight to the
/// home screen. Delete the file (or reinstall the OS) to see onboarding
/// again.
class OnboardingState {
  static File get _marker {
    final dataHome = Platform.environment['XDG_DATA_HOME'] ??
        '${Platform.environment['HOME'] ?? '/tmp'}/.local/share';
    return File('$dataHome/tomoro/onboarding_done');
  }

  static bool get isDone {
    try {
      return _marker.existsSync();
    } on FileSystemException {
      return false;
    }
  }

  static void markDone() {
    try {
      _marker.createSync(recursive: true);
    } on FileSystemException {
      // Non-fatal: onboarding will show again next boot.
    }
  }
}
