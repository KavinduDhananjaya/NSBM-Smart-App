import 'package:flutter/material.dart';

@immutable
class LectureHallBookingState {
  final String error;

  LectureHallBookingState({
    @required this.error,
  });

  static LectureHallBookingState get initialState => LectureHallBookingState(
    error: '',
  );

  LectureHallBookingState clone({
    String error,
  }) {
    return LectureHallBookingState(
      error: error ?? this.error,
    );
  }
}
