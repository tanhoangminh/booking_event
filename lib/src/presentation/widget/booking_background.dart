import 'package:booking_event/booking_event.dart';
import 'package:flutter/material.dart';

import 'hour_painter.dart';

class BookingBackground extends StatelessWidget {
  const BookingBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    final timeRange =
        widget.config.endHourBooking - widget.config.startHourBooking;

    return Row(
      children: List.generate(
        timeRange,
        (index) => SizedBox(
          width: timeRange * widget.config.timeWidth,
          height: widget.config.seatHeight * widget.config.seatRange,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: HourPainter(widget.config)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
