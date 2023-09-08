import 'package:flutter/material.dart';

abstract class BookingConfig {
  final int startHourBooking;
  final int endHourBooking;
  final Color bookingColor;
  final int seatRange;
  final Color seatColor;
  final double seatHeight;
  final double seatWidth;
  final double timeHeight;
  final double timeWidth;

  BookingConfig({
    this.startHourBooking = 0,
    this.endHourBooking = 24,
    this.bookingColor = Colors.orange,
    this.seatColor = Colors.orange,
    this.seatHeight = 50,
    this.seatWidth = 100,
    this.timeHeight = 50,
    this.timeWidth = 100,
    this.seatRange = 30,
  });
}

class DefaultBookingConfig extends BookingConfig {}
