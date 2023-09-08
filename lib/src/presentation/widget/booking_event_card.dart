import 'package:booking_event/booking_event.dart';
import 'package:booking_event/src/domain/booking_event.dart';
import 'package:booking_event/ultils/time_utils.dart';
import 'package:flutter/material.dart';

class BookingEventCard extends StatelessWidget {
  const BookingEventCard({Key? key, required this.event}) : super(key: key);
  final BookingEvent event;

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    final left = event.start.hour * widget.config.timeWidth +
        (widget.config.timeWidth / 60) * event.start.minute;

    return Positioned(
      top: (event.seat.index - 1) * 50,
      left: left,
      child: GestureDetector(
        onTap: () {
          widget.controller.removeBooking(event);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: widget.config.seatHeight,
          width: widget.config.timeWidth * (event.end.hour - event.start.hour),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 4,
              )
            ],
          ),
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Seat: ${event.seat.index}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                '${TimeUtils.hourFormatter(event.start.hour, event.start.minute)} - ${TimeUtils.hourFormatter(event.end.hour, event.end.minute)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
