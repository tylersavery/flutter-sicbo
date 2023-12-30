import 'package:flutter/material.dart';
import 'package:sicbo/src/models/bid_amount.dart';

class ChipPainter extends CustomPainter {
  final BidAmount amount;

  ChipPainter({
    required this.amount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer circle
    final outerCirclePaint = Paint()
      ..color = amount.color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, outerCirclePaint);

    // Draw inner circle
    final innerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.8, innerCirclePaint);

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw text in the center
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${amount.value}',
        style: TextStyle(
          color: Colors.black,
          fontSize: size.width / 2.75,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
