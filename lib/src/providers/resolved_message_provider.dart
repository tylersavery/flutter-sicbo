import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResolvedMessageProvider extends StateNotifier<String?> {
  ResolvedMessageProvider() : super(null);

  set(String message) {
    state = message;
  }

  clear() {
    state = null;
  }
}

final resolvedMessageProvider = StateNotifierProvider<ResolvedMessageProvider, String?>((ref) {
  return ResolvedMessageProvider();
});
