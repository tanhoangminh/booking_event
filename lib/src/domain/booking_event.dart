import 'package:booking_event/src/domain/seat.dart';
import 'package:booking_event/src/domain/time_event.dart';

class BookingEvent {
  final Seat seat;
  final TimeEvent start;
  final TimeEvent end;

  const BookingEvent._(this.seat, this.start, this.end);

  factory BookingEvent.create({
    required int index,
    required TimeEvent start,
    required TimeEvent end,
  }) {
    return BookingEvent._(
      Seat(index),
      start,
      end,
    );
  }
}