import 'package:flutter_riverpod/flutter_riverpod.dart';

class RollHistoryProvider extends StateNotifier<List<List<int>>> {
  RollHistoryProvider() : super([]);

  add(List<int> roll) {
    state = [roll, ...state];
  }

  clear() {
    state = [];
  }
}

final rollHistoryProvider = StateNotifierProvider<RollHistoryProvider, List<List<int>>>((ref) {
  return RollHistoryProvider();
});
