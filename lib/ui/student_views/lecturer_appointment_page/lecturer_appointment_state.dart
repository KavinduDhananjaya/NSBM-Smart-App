import 'package:flutter/material.dart';

@immutable
class LectureAppointmentState {
  final String error;

  LectureAppointmentState({
    @required this.error,
  });

  static LectureAppointmentState get initialState => LectureAppointmentState(
    error: '',
  );

  LectureAppointmentState clone({
    String error,
  }) {
    return LectureAppointmentState(
      error: error ?? this.error,
    );
  }
}
