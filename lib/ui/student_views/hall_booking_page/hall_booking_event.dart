import 'package:flutter/material.dart';

@immutable
abstract class HallBookingEvent {}

class ErrorEvent extends HallBookingEvent {
  final String error;

  ErrorEvent(this.error);
}
