import 'package:booking_event/booking_event.dart';
import 'package:flutter/material.dart';

class SeatPainter extends CustomPainter {
  final BookingConfig config;

  SeatPainter(this.config);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 20, size.width, size.height - 20),
      Paint()..color = Colors.white,
    );
    for (int min = 0; min <= 60;) {
      double topOffset = calculateTopOffset(min);
      if ([0, 30, 60].contains(min)) {
        canvas.drawLine(
          Offset(topOffset, size.height),
          Offset(topOffset, size.height - 15),
          Paint()
            ..color = const Color(0x1A000000)
            ..strokeWidth = 1,
        );
      } else {
        canvas.drawLine(
          Offset(topOffset, size.height),
          Offset(topOffset, size.height - 10),
          Paint()..color = const Color(0x1A000000),
        );
      }
      min += 5;
    }
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return false;
  }

  double calculateTopOffset(int min) => min * config.timeWidth / 60;
}
