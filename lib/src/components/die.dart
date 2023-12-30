import 'package:flutter/material.dart';
import 'package:sicbo/src/painters/dice_painter.dart';

class Die extends StatelessWidget {
  final int value;
  final double size;
  const Die({
    super.key,
    required this.value,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size / 6),
          ),
          child: CustomPaint(
            size: Size(size - 8, size - 8),
            painter: DicePainter(value),
          ),
        ),
      ),
    );
  }
}
