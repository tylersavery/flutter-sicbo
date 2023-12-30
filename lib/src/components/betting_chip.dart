import 'package:flutter/material.dart';
import 'package:sicbo/src/models/bid_amount.dart';
import 'package:sicbo/src/painters/chip_painter.dart';

class BettingChip extends StatelessWidget {
  final BidAmount amount;
  final double size;
  final bool selected;
  final Function()? onPressed;
  const BettingChip({
    super.key,
    required this.amount,
    this.size = 48.0,
    this.selected = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: selected ? 1 : 0.5,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            size: Size(size, size),
            painter: ChipPainter(amount: amount),
          ),
        ),
      ),
    );
  }
}
