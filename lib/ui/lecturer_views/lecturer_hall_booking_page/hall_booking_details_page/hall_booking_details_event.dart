import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/ui/student_views/hall_booking_page/hall_booking_event.dart';

@immutable
abstract class HallBookingDetailsEvent {}

class ErrorEvent extends HallBookingDetailsEvent {
  final String error;

  ErrorEvent(this.error);
}

class ConfirmEvent extends HallBookingDetailsEvent{
  final HallRequest request;

  ConfirmEvent(this.request);
}


class RejectEvent extends HallBookingDetailsEvent{
  final HallRequest request;

  RejectEvent(this.request);
}
