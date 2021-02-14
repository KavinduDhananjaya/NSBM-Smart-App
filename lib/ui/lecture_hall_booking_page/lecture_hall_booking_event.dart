import 'package:flutter/material.dart';

@immutable
abstract class LectureHallBookingEvent {}

class ErrorEvent extends LectureHallBookingEvent {
  final String error;

  ErrorEvent(this.error);
}
