import 'package:flutter/material.dart';

enum BidAmount {
  one(1, Colors.brown),
  five(5, Colors.blue),
  ten(10, Colors.purple),
  twenty(20, Colors.green),
  fifty(50, Colors.red),
  hundred(100, Colors.yellow);

  final int value;
  final Color color;

  const BidAmount(this.value, this.color);
}
