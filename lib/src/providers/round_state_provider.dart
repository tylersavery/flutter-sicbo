import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/models/bid_type.dart';
import 'package:sicbo/src/providers/bids_provider.dart';
import 'package:sicbo/src/providers/player_provider.dart';
import 'package:sicbo/src/providers/resolved_message_provider.dart';
import 'package:sicbo/src/providers/roll_history_provider.dart';
import 'package:sicbo/src/providers/roll_provider.dart';
import 'package:sicbo/src/providers/winning_bid_types_provider.dart';

enum RoundState {
  betting,
  rolling,
  resolving,
}

class RoundStateProvider extends StateNotifier<RoundState> {
  final Ref ref;
  RoundStateProvider(this.ref) : super(RoundState.betting);

  set(RoundState roundState) {
    state = roundState;
  }

  bet() {
    ref.read(resolvedMessageProvider.notifier).clear();
    ref.read(winningBidTypesProvider.notifier).clear();

    state = RoundState.betting;
    final bidSum = ref.watch(bidsProvider).fold(0, (a, b) => a + b.amount);

    ref.read(playerProvider.notifier).addCredits(-bidSum);
    ref.read(bidsProvider.notifier).clear();
  }

  roll() async {
    if (ref.read(rollProvider) != null) {
      ref.read(rollHistoryProvider.notifier).add(ref.read(rollProvider)!);
    }

    ref.read(bidsProvider.notifier).lockBids();

    state = RoundState.rolling;
    await ref.read(rollProvider.notifier).randomize();

    await Future.delayed(Duration(milliseconds: 1000));
    resolve();
  }

  resolve() async {
    state = RoundState.resolving;
    final bids = ref.read(bidsProvider);
    final roll = ref.read(rollProvider);

    if (roll == null) return;

    for (final type in BidType.values) {
      final win = isWinner(type, roll);
      if (win) {
        ref.read(winningBidTypesProvider.notifier).add(type);
      }
    }

    int credits = 0;
    for (final bid in bids) {
      final amount = bid.resolveCredits(roll);
      credits += amount;
      final win = isWinner(bid.type, roll);
      if (win) {
        credits += bid.amount;
      }
    }

    final creditDelta = credits - bids.fold(0, (a, b) => a + b.amount);

    if (creditDelta > 0) {
      ref.read(resolvedMessageProvider.notifier).set("You won $creditDelta credits!");
    } else if (creditDelta < 0) {
      ref.read(resolvedMessageProvider.notifier).set("You lost ${-creditDelta} credits.");
    } else {
      if (bids.isNotEmpty) {
        ref.read(resolvedMessageProvider.notifier).set("Zero-sum round.");
      }
    }

    ref.read(playerProvider.notifier).addCredits(credits);
  }
}

final roundStateProvider = StateNotifierProvider<RoundStateProvider, RoundState>((ref) {
  return RoundStateProvider(ref);
});
