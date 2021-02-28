import 'package:flutter/material.dart';

@immutable
class LecturerProfileState {
  final String error;

  LecturerProfileState({
    @required this.error,
  });

  static LecturerProfileState get initialState => LecturerProfileState(
    error: '',
  );

  LecturerProfileState clone({
    String error,
  }) {
    return LecturerProfileState(
      error: error ?? this.error,
    );
  }
}
