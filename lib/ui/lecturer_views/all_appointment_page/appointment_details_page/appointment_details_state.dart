import 'package:flutter/material.dart';

@immutable
class AppointmentDetailsState {
  final String error;
  final int state;

  AppointmentDetailsState({
    @required this.error,
    @required this.state,
  });

  static AppointmentDetailsState get initialState => AppointmentDetailsState(
        error: '',
        state: 0,
      );

  AppointmentDetailsState clone({
    String error,
    int state,
  }) {
    return AppointmentDetailsState(
      error: error ?? this.error,
      state: state ?? this.state,
    );
  }
}
