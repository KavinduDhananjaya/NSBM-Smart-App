import 'package:flutter/material.dart';

@immutable
abstract class ProfileEvent {}

class ErrorEvent extends ProfileEvent {
  final String error;

  ErrorEvent(this.error);
}
