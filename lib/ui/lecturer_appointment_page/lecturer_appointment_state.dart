import 'package:flutter/material.dart';

@immutable
class LecturerAppointmentState {
  final String error;

  LecturerAppointmentState({
    @required this.error,
  });

  static LecturerAppointmentState get initialState => LecturerAppointmentState(
    error: '',
  );

  LecturerAppointmentState clone({
    String error,
  }) {
    return LecturerAppointmentState(
      error: error ?? this.error,
    );
  }
}
