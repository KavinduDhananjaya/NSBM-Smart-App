import 'package:flutter/material.dart';

@immutable
abstract class EventsEvent {}

class ErrorEvent extends EventsEvent {
  final String error;

  ErrorEvent(this.error);
}
