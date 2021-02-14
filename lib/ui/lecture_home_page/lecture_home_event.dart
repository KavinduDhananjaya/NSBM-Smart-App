import 'package:flutter/material.dart';

@immutable
abstract class LectureHomeEvent {}

class ErrorEvent extends LectureHomeEvent {
  final String error;

  ErrorEvent(this.error);
}
