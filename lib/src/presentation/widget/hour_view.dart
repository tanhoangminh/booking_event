import 'package:booking_event/booking_event.dart';
import 'package:booking_event/src/presentation/widget/seat_painter.dart';
import 'package:booking_event/ultils/time_utils.dart';
import 'package:flutter/material.dart';

import 'booking_wrapper.dart';

class HourView extends StatelessWidget {
  const HourView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    final state = BookingWrapperState.of(context);

    return Container(
      height: widget.config.timeHeight,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: widget.config.seatWidth),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: state.horizontalScrollController,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemExtent: widget.config.timeWidth,
        children: <int>[
          for (var i = widget.config.startHourBooking;
              i < widget.config.endHourBooking;
              i++)
            i
        ].map((e) => _TimeBox(hour: e)).toList(),
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({Key? key, required this.hour}) : super(key: key);
  final int hour;

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    return Container(
      height: widget.config.timeHeight,
      width: widget.config.timeWidth,
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              TimeUtils.hourFormatter(hour, 0),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(painter: SeatPainter(widget.config)),
          ),
        ],
      ),
    );
  }
}
