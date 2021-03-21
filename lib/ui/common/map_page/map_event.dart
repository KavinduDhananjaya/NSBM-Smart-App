import 'package:flutter/material.dart';

@immutable
abstract class MapEvent {}

class ErrorEvent extends MapEvent {
  final String error;

  ErrorEvent(this.error);
}
