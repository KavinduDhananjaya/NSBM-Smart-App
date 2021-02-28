import 'package:flutter/material.dart';

@immutable
class HallBookingDetailsState {
  final String error;

  HallBookingDetailsState({
    @required this.error,
  });

  static HallBookingDetailsState get initialState => HallBookingDetailsState(
    error: '',
  );

  HallBookingDetailsState clone({
    String error,
  }) {
    return HallBookingDetailsState(
      error: error ?? this.error,
    );
  }
}
