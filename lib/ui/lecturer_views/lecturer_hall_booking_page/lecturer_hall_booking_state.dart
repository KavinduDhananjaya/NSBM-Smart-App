import 'package:flutter/material.dart';

@immutable
class LecturerHallBookingState {
  final String error;

  LecturerHallBookingState({
    @required this.error,
  });

  static LecturerHallBookingState get initialState => LecturerHallBookingState(
    error: '',
  );

  LecturerHallBookingState clone({
    String error,
  }) {
    return LecturerHallBookingState(
      error: error ?? this.error,
    );
  }
}
