import 'package:flutter/material.dart';

@immutable
abstract class LecturerProfileEvent {}

class ErrorEvent extends LecturerProfileEvent {
  final String error;

  ErrorEvent(this.error);
}
