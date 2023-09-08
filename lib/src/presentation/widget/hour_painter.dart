import 'package:booking_event/booking_event.dart';
import 'package:flutter/material.dart';

class HourPainter extends CustomPainter {
  final BookingConfig config;

  HourPainter(this.config);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );
    for (int seat = 0; seat < config.seatRange; seat++) {
      double topOffset = calculateTopOffset(seat);
      canvas.drawLine(
        Offset(0, topOffset),
        Offset(size.width, topOffset),
        Paint()
          ..color = const Color(0x1A000000)
          ..strokeWidth = 1,
      );
    }

    for (int hour = config.startHourBooking;
        hour <= config.endHourBooking;
        hour++) {
      double topOffset = calculateHourOffset(hour);
      canvas.drawLine(
        Offset(topOffset, 0),
        Offset(topOffset, size.height),
        Paint()
          ..color = const Color(0x1A000000)
          ..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return false;
  }

  double calculateTopOffset(int seat) => seat * config.seatHeight;

  double calculateHourOffset(int hour) => hour * config.timeWidth;
}
