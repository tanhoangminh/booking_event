import 'package:booking_event/booking_event.dart';
import 'package:flutter/material.dart';

import 'booking_wrapper.dart';

class SeatView extends StatelessWidget {
  const SeatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingWidget = BookingWidget.of(context);

    final state = BookingWrapperState.of(context);

    return Container(
      width: bookingWidget.config.seatWidth,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: bookingWidget.config.timeHeight),
      child: ListView(
        controller: state.verticalScrollController,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemExtent: bookingWidget.config.seatHeight,
        children: List<Widget>.generate(bookingWidget.config.seatRange, (index) {
          return _SeatCard(number: index + 1);
        }).toList(),
      ),
    );
  }
}

class _SeatCard extends StatelessWidget {
  const _SeatCard({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    return Container(
      height: widget.config.seatHeight,
      width: widget.config.seatWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.config.seatColor,
        border: Border.all(color: Colors.white, width: 0.5)
      ),
      child: Text(
        number.toString().padLeft(2, '0'),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
