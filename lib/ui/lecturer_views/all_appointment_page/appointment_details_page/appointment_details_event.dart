import 'package:flutter/material.dart';

@immutable
abstract class AppointmentDetailsEvent {}

class ErrorEvent extends AppointmentDetailsEvent {
  final String error;

  ErrorEvent(this.error);
}
