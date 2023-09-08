import 'package:booking_event/src/presentation/booking_widget.dart';
import 'package:booking_event/src/presentation/controller/booking_table_controller.dart';
import 'package:booking_event/src/presentation/widget/seat_view.dart';
import 'package:flutter/material.dart';

import 'booking_sheet.dart';
import 'hour_view.dart';

class BookingWrapper extends StatefulWidget {
  const BookingWrapper({Key? key}) : super(key: key);

  @override
  State<BookingWrapper> createState() => BookingWrapperState();
}

class BookingWrapperState extends State<BookingWrapper>
    with BookingTableController {
  late final BookingWidget bookingWidget;

  static BookingWrapperState of(BuildContext context) {
    final state = context.findAncestorStateOfType<BookingWrapperState>();
    if (state == null) {
      throw Exception("BookingWrapperState.of(context) is null");
    }
    return state;
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: const [
          SeatView(),
          HourView(),
          BookingSheet(),
        ],
      ),
    );
  }
}
