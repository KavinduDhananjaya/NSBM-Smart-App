import 'package:flutter/material.dart';

@immutable
abstract class ChatEvent {}

class ErrorEvent extends ChatEvent {
  final String error;

  ErrorEvent(this.error);
}
