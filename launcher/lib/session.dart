import 'package:flutter/material.dart';

/// In-memory state for the current sign-in session.
///
/// Set by the organisation login screen once the OTP is accepted; read by
/// later screens (e.g. the patient profile greeting). Resets on app restart.
class Session {
  static String? patientName;

  /// Current UI locale. The language screen writes it; [MaterialApp]
  /// listens and rebuilds, so the whole app switches language live.
  static final locale = ValueNotifier<Locale>(const Locale('en'));

  /// First word of the patient's name, for casual greetings.
  static String get firstName {
    final name = patientName;
    if (name == null || name.isEmpty) return 'there';
    return name.split(' ').first;
  }
}
