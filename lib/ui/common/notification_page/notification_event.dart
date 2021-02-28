import 'package:flutter/material.dart';

@immutable
abstract class NotificationEvent {}

class ErrorEvent extends NotificationEvent {
  final String error;

  ErrorEvent(this.error);
}
