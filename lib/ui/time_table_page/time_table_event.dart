import 'package:flutter/material.dart';

@immutable
abstract class TimeTableEvent {}

class ErrorEvent extends TimeTableEvent {
  final String error;

  ErrorEvent(this.error);
}
