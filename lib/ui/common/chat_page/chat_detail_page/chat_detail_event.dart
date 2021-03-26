import 'package:flutter/material.dart';

@immutable
abstract class ChatDetailEvent {}

class ErrorEvent extends ChatDetailEvent {
  final String error;

  ErrorEvent(this.error);
}
