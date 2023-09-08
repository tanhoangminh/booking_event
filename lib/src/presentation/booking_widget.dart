import 'package:booking_event/src/domain/booking_config.dart';
import 'package:booking_event/src/presentation/widget/booking_wrapper.dart';
import 'package:flutter/cupertino.dart';

import 'controller/booking_controller.dart';

class BookingWidget extends InheritedWidget {
  final BookingConfig config;
  final BookingController controller;

  const BookingWidget({
    super.key,
    required this.config,
    Widget? child,
    required this.controller,
  }) : super(child: const BookingWrapper());

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static BookingWidget of(BuildContext context) {
    final widget = context.findAncestorWidgetOfExactType<BookingWidget>();
    if (widget == null) throw Exception("BookingWidget.of(context) is null");
    return widget;
  }
}
