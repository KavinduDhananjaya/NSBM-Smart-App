import 'package:flutter/material.dart';

@immutable
abstract class LectureAppointmentDetailsEvent {}

class ErrorEvent extends LectureAppointmentDetailsEvent {
  final String error;

  ErrorEvent(this.error);
}
