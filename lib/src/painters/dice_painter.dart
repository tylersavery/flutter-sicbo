import 'package:flutter/material.dart';

class DicePainter extends CustomPainter {
  final int diceNumber;

  DicePainter(this.diceNumber);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final dotSize = size.width / 8;
    final spacing = size.width / 5;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    void drawDot(double x, double y) {
      canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
    }

    void drawDotsForNumber(int number) {
      switch (number) {
        case 1:
          drawDot(centerX, centerY);
          break;
        case 2:
          drawDot(centerX - spacing, centerY - spacing);
          drawDot(centerX + spacing, centerY + spacing);
          break;
        case 3:
          drawDot(centerX, centerY);
          drawDot(centerX - spacing, centerY - spacing);
          drawDot(centerX + spacing, centerY + spacing);
          break;
        case 4:
          drawDot(centerX - spacing, centerY - spacing);
          drawDot(centerX + spacing, centerY - spacing);
          drawDot(centerX - spacing, centerY + spacing);
          drawDot(centerX + spacing, centerY + spacing);
          break;
        case 5:
          drawDot(centerX, centerY);
          drawDot(centerX - spacing, centerY - spacing);
          drawDot(centerX + spacing, centerY - spacing);
          drawDot(centerX - spacing, centerY + spacing);
          drawDot(centerX + spacing, centerY + spacing);
          break;
        case 6:
          drawDot(centerX - spacing, centerY - spacing);
          drawDot(centerX + spacing, centerY - spacing);
          drawDot(centerX - spacing, centerY);
          drawDot(centerX + spacing, centerY);
          drawDot(centerX - spacing, centerY + spacing);
          drawDot(centerX + spacing, centerY + spacing);
          break;
      }
    }

    drawDotsForNumber(diceNumber);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
