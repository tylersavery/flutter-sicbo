import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/providers/bids_provider.dart';
import 'package:sicbo/src/providers/player_provider.dart';

class AvailableCreditsProvider extends StateNotifier<int> {
  AvailableCreditsProvider(int initialState) : super(initialState);
}

final availableCreditsProvider = StateNotifierProvider<AvailableCreditsProvider, int>((ref) {
  final player = ref.watch(playerProvider);
  final bidSum = ref.watch(bidsProvider).fold(0, (a, b) => a + b.amount);
  final availableCredits = player.credits - bidSum;

  return AvailableCreditsProvider(availableCredits);
});
