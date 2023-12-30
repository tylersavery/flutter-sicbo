// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sicbo/src/models/bid.dart';

import "package:collection/collection.dart";
import 'package:sicbo/src/models/bid_amount.dart';
import 'package:sicbo/src/models/bid_type.dart';

class BidsProvider extends StateNotifier<List<Bid>> {
  BidsProvider() : super([]);

  set(List<Bid> bids) {
    state = bids;
  }

  clear() {
    state = [];
  }

  add(
    BidType type,
    BidAmount amount,
  ) {
    final existing = state.firstWhereOrNull((b) => b.type == type);

    if (existing != null) {
      final newBid = Bid(type: type, amount: existing.amount + amount.value);
      state = [...state]
        ..removeWhere((b) => b.type == type)
        ..add(newBid);
    } else {
      state = [...state, Bid(type: type, amount: amount.value)];
    }
  }

  subtract(
    BidType type,
    BidAmount amount,
  ) {
    final existing = state.firstWhereOrNull((b) => b.type == type);

    if (existing != null) {
      final newValue = max(0, existing.amount - amount.value);

      final newBid = Bid(type: type, amount: newValue);
      state = [...state]
        ..removeWhere((b) => b.type == type)
        ..add(newBid);
    }
  }

  remove(Bid bid) {
    state = [...state]..removeWhere((b) => b.type == bid.type);
  }

  lockBids() {
    final List<Bid> newState = [];

    for (final b in state) {
      newState.add(b.lock());
    }

    state = newState;
  }
}

final bidsProvider = StateNotifierProvider<BidsProvider, List<Bid>>((ref) {
  return BidsProvider();
});
