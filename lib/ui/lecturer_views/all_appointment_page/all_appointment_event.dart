import 'package:flutter/material.dart';

@immutable
abstract class AllAppointmentEvent {}

class ErrorEvent extends AllAppointmentEvent {
  final String error;

  ErrorEvent(this.error);
}
