import 'package:flutter/material.dart';

@immutable
abstract class LecturerHomeEvent {}

class ErrorEvent extends LecturerHomeEvent {
  final String error;

  ErrorEvent(this.error);
}
