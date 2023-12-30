import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/models/bid_type.dart';

class WinningBidTypesProvider extends StateNotifier<List<BidType>> {
  WinningBidTypesProvider() : super([]);

  add(BidType type) {
    state = [...state, type];
  }

  clear() {
    state = [];
  }
}

final winningBidTypesProvider = StateNotifierProvider<WinningBidTypesProvider, List<BidType>>((ref) {
  return WinningBidTypesProvider();
});
