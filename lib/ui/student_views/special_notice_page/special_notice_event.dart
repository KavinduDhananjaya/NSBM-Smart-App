import 'package:flutter/material.dart';

@immutable
abstract class SpecialNoticeEvent {}

class ErrorEvent extends SpecialNoticeEvent {
  final String error;

  ErrorEvent(this.error);
}
