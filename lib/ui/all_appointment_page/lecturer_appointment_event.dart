import 'package:flutter/material.dart';

@immutable
abstract class LecturerAppointmentEvent {}

class ErrorEvent extends LecturerAppointmentEvent {
  final String error;

  ErrorEvent(this.error);
}
