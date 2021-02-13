import 'package:flutter/material.dart';

@immutable
abstract class LectureAppointmentEvent {}

class ErrorEvent extends LectureAppointmentEvent {
  final String error;

  ErrorEvent(this.error);
}
