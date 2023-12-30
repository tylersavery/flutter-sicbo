import 'dart:math';
import 'package:sicbo/src/models/bid_amount.dart';
import 'package:sicbo/src/models/bid_type.dart';

class Bid {
  final BidType type;
  final int amount;
  final bool locked;

  const Bid({
    required this.type,
    this.amount = 0,
    this.locked = false,
  });

  Bid addAmount(int value) {
    return Bid(
      type: type,
      amount: amount + value,
      locked: locked,
    );
  }

  Bid subtractAmount(int value) {
    final newValue = max(0, amount - value);
    return Bid(
      type: type,
      amount: newValue,
      locked: locked,
    );
  }

  Bid lock() {
    return Bid(
      type: type,
      amount: amount,
      locked: true,
    );
  }

  List<BidAmount> get denominations {
    final List<BidAmount> amounts = [];

    final coins = determineCoinCombination(BidAmount.values.map((b) => b.value).toList(), amount);

    for (final entry in coins.entries) {
      final value = BidAmount.values.firstWhere((e) => e.value == entry.key);
      final amount = entry.value;
      for (int i = 0; i < amount; i++) {
        amounts.add(value);
      }
    }

    amounts.sort((a, b) => a.value > b.value ? -1 : 1);

    return amounts;
  }

  Map<int, int> determineCoinCombination(List<int> availableCoins, int targetValue) {
    List<int> dp = List<int>.filled(targetValue + 1, targetValue + 1);
    dp[0] = 0;

    List<int> coinUsed = List<int>.filled(targetValue + 1, -1);

    for (int i = 1; i <= targetValue; i++) {
      for (int coin in availableCoins) {
        if (i >= coin && dp[i - coin] + 1 < dp[i]) {
          dp[i] = dp[i - coin] + 1;
          coinUsed[i] = coin;
        }
      }
    }

    if (dp[targetValue] == targetValue + 1) {
      return {};
    }

    Map<int, int> coinCombination = {};
    int remainingValue = targetValue;
    while (remainingValue > 0) {
      int coin = coinUsed[remainingValue];
      coinCombination.update(coin, (value) => value + 1, ifAbsent: () => 1);
      remainingValue -= coin;
    }

    return coinCombination;
  }

  int resolveCredits(List<int> roll) {
    final win = isWinner(type, roll);

    if (win) {
      if ([
        BidType.singleOne,
        BidType.singleTwo,
        BidType.singleThree,
        BidType.singleFour,
        BidType.singleFive,
        BidType.singleSix,
      ].contains(type)) {
        return amount * type.multiplier * roll.where((r) => r == type.value).length;
      }

      return amount * type.multiplier;
    }

    return 0;
  }
}
