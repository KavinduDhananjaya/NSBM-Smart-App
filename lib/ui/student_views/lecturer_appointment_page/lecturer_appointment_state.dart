import 'package:flutter/material.dart';

@immutable
class LectureAppointmentState {
  static const INITIAL = 0;
  static const PROCESSING = 1;
  static const COMPLETE = 2;

  final String error;
  final int type;
  final int state;

  LectureAppointmentState({
    @required this.error,
    @required this.state,
    @required this.type,
  });

  static LectureAppointmentState get initialState => LectureAppointmentState(
        error: '',
        type: 1,
        state: INITIAL,
      );

  LectureAppointmentState clone({
    String error,
    int type,
    int state,
  }) {
    return LectureAppointmentState(
      error: error ?? this.error,
      state: state ?? this.state,
      type: type ?? this.type,
    );
  }
}
