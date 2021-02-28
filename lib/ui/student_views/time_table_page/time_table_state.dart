import 'package:flutter/material.dart';

@immutable
class TimeTableState {
  final String error;

  TimeTableState({
    @required this.error,
  });

  static TimeTableState get initialState => TimeTableState(
    error: '',
  );

  TimeTableState clone({
    String error,
  }) {
    return TimeTableState(
      error: error ?? this.error,
    );
  }
}
