import 'package:flutter/material.dart';

@immutable
class HallBookingDetailsState {
  final String error;
  final int state;

  HallBookingDetailsState({
    @required this.error,
    @required this.state,
  });

  static HallBookingDetailsState get initialState => HallBookingDetailsState(
        error: '',
        state: 0,
      );

  HallBookingDetailsState clone({
    String error,
    int state,
  }) {
    return HallBookingDetailsState(
      error: error ?? this.error,
      state: state ?? this.state,
    );
  }
}
