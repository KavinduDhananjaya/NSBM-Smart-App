import 'package:flutter/material.dart';

@immutable
class LecturerHomeState {
  final String error;

  LecturerHomeState({
    @required this.error,
  });

  static LecturerHomeState get initialState => LecturerHomeState(
    error: '',
  );

  LecturerHomeState clone({
    String error,
  }) {
    return LecturerHomeState(
      error: error ?? this.error,
    );
  }
}
