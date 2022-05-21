import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class RoundedAmebaThumbShape extends SliderComponentShape {
  final double radius;
  final Color color;

  const RoundedAmebaThumbShape({
    required this.radius,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint = Paint()..color = color;

    final rect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(center.dx - 8.0, center.dy + 5.0),
        Offset(center.dx + 8.0, center.dy - 5.0),
      ),
      Radius.circular(radius + 5.0),
    );

    canvas.drawRRect(rect, paint);
  }
}
