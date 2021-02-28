import 'package:flutter/material.dart';

@immutable
class NotificationState {
  final String error;

  NotificationState({
    @required this.error,
  });

  static NotificationState get initialState => NotificationState(
    error: '',
  );

  NotificationState clone({
    String error,
  }) {
    return NotificationState(
      error: error ?? this.error,
    );
  }
}
