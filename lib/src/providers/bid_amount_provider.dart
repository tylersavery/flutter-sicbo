import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/models/bid_amount.dart';

class BidAmountProvider extends StateNotifier<BidAmount> {
  BidAmountProvider() : super(BidAmount.one);

  set(BidAmount amount) {
    state = amount;
  }
}

final bidAmountProvider = StateNotifierProvider<BidAmountProvider, BidAmount>((ref) {
  return BidAmountProvider();
});
