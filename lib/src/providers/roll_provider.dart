// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const DEBUG = false;
const DEBUG_VALUE = [1, 1, 2];

class RollProvider extends StateNotifier<List<int>?> {
  RollProvider() : super(null);

  randomize([int animations = 5]) async {
    Random random = Random();

    int i = 0;
    while (i <= animations) {
      i++;
      state = [random.nextInt(6) + 1, random.nextInt(6) + 1, random.nextInt(6) + 1];
      await Future.delayed(Duration(milliseconds: 100));
    }

    if (DEBUG) {
      state = DEBUG_VALUE;
    }
  }
}

final rollProvider = StateNotifierProvider<RollProvider, List<int>?>((ref) {
  return RollProvider();
});
