import 'package:flutter/material.dart';

@immutable
class LectureAppointmentDetailsState {
  final String error;

  LectureAppointmentDetailsState({
    @required this.error,
  });

  static LectureAppointmentDetailsState get initialState => LectureAppointmentDetailsState(
    error: '',
  );

  LectureAppointmentDetailsState clone({
    String error,
  }) {
    return LectureAppointmentDetailsState(
      error: error ?? this.error,
    );
  }
}
