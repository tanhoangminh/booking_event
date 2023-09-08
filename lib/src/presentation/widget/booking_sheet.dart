import 'package:booking_event/booking_event.dart';
import 'package:booking_event/src/domain/booking_event.dart';
import 'package:booking_event/src/domain/time_event.dart';
import 'package:booking_event/src/presentation/widget/booking_event_card.dart';
import 'package:booking_event/src/presentation/widget/table_scroll_view.dart';
import 'package:flutter/material.dart';

import 'booking_background.dart';
import 'booking_wrapper.dart';

class BookingSheet extends StatelessWidget {
  const BookingSheet({Key? key}) : super(key: key);

  void _onTapUp(BuildContext context, Offset offset) {
    final widget = BookingWidget.of(context);

    final dy = offset.dy;
    final seat = dy ~/ widget.config.timeHeight + 1;

    final dx = offset.dx;
    final hour = dx ~/ widget.config.timeWidth;
    final min = dx / widget.config.timeWidth - hour;
    if (min == 1) {
      final start = TimeEvent(hour: hour + 1, minute: 0);
      final end = TimeEvent(hour: start.hour + 2, minute: 0);
      widget.controller.createBooking(BookingEvent.create(
        index: seat,
        start: start,
        end: end,
      ));
      return;
    }
    final start = TimeEvent(hour: hour, minute: (min * 60).round());
    final end = TimeEvent(hour: start.hour + 2, minute: start.minute);
    widget.controller.createBooking(BookingEvent.create(
      index: seat,
      start: start,
      end: end,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final widget = BookingWidget.of(context);

    final state = BookingWrapperState.of(context);

    final maxW = widget.config.timeWidth *
        (widget.config.endHourBooking - widget.config.startHourBooking);

    return Padding(
      padding: EdgeInsets.only(
        top: widget.config.timeHeight,
        left: widget.config.seatWidth,
      ),
      child: TableScrollView(
        onTapUp: (off) => _onTapUp(context, off),
        horizontalPixelsStreamController: state.horizontalPixelsStream,
        verticalPixelsStreamController: state.verticalPixelsStream,
        onScroll: state.onScroll,
        maxWidth: maxW,
        maxHeight: widget.config.seatHeight * widget.config.seatRange,
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (_, __) {
            return Stack(
              children: [
                const BookingBackground(),
                ...widget.controller.events
                    .map<Widget>((e) => BookingEventCard(event: e))
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
