import 'package:flutter/material.dart';

@immutable
class HallBookingState {

  static const INITIAL=0;
  static const PROCESSING=1;
  static const COMPLETE=2;


  final String error;
  final int type;
  final int state;

  HallBookingState({
    @required this.error,
    @required this.type,
    @required this.state,
  });

  static HallBookingState get initialState => HallBookingState(
        error: '',
        type: 1,
        state: INITIAL,
      );

  HallBookingState clone({
    String error,
    int type,
    int state,
  }) {
    return HallBookingState(
      error: error ?? this.error,
      type: type ?? this.type,
      state: state ?? this.state,
    );
  }
}
