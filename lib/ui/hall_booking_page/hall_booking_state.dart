import 'package:flutter/material.dart';

@immutable
class HallBookingState {
  final String error;

  HallBookingState({
    @required this.error,
  });

  static HallBookingState get initialState => HallBookingState(
    error: '',
  );

  HallBookingState clone({
    String error,
  }) {
    return HallBookingState(
      error: error ?? this.error,
    );
  }
}
