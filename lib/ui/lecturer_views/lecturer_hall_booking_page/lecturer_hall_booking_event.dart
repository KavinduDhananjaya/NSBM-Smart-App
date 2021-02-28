import 'package:flutter/material.dart';

@immutable
abstract class LecturerHallBookingEvent {}

class ErrorEvent extends LecturerHallBookingEvent {
  final String error;

  ErrorEvent(this.error);
}
