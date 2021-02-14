import 'package:flutter/material.dart';

@immutable
class LectureHomeState {
  final String error;

  LectureHomeState({
    @required this.error,
  });

  static LectureHomeState get initialState => LectureHomeState(
    error: '',
  );

  LectureHomeState clone({
    String error,
  }) {
    return LectureHomeState(
      error: error ?? this.error,
    );
  }
}
