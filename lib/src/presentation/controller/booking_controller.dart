import 'package:booking_event/src/domain/booking_event.dart';
import 'package:flutter/cupertino.dart';

class BookingController extends ChangeNotifier {
  List<BookingEvent> _events = [];

  List<BookingEvent> get events => _events;

  void createBooking(BookingEvent val) {
    _events = [..._events, val];
    notifyListeners();
  }

  void removeBooking(BookingEvent val) {
    _events.remove(val);
    notifyListeners();
  }
}