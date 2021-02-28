import 'package:flutter/material.dart';

@immutable
class AppointmentDetailsState {
  final String error;

  AppointmentDetailsState({
    @required this.error,
  });

  static AppointmentDetailsState get initialState => AppointmentDetailsState(
    error: '',
  );

  AppointmentDetailsState clone({
    String error,
  }) {
    return AppointmentDetailsState(
      error: error ?? this.error,
    );
  }
}
