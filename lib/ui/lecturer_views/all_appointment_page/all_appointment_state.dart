import 'package:flutter/material.dart';

@immutable
class AllAppointmentState {
  final String error;

  AllAppointmentState({
    @required this.error,
  });

  static AllAppointmentState get initialState => AllAppointmentState(
    error: '',
  );

  AllAppointmentState clone({
    String error,
  }) {
    return AllAppointmentState(
      error: error ?? this.error,
    );
  }
}
