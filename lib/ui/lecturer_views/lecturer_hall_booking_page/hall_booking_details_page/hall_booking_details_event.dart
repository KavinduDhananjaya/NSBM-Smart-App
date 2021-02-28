import 'package:flutter/material.dart';

@immutable
abstract class HallBookingDetailsEvent {}

class ErrorEvent extends HallBookingDetailsEvent {
  final String error;

  ErrorEvent(this.error);
}
