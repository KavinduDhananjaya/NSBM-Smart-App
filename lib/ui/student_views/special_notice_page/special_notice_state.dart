import 'package:flutter/material.dart';

@immutable
class SpecialNoticeState {
  final String error;

  SpecialNoticeState({
    @required this.error,
  });

  static SpecialNoticeState get initialState => SpecialNoticeState(
    error: '',
  );

  SpecialNoticeState clone({
    String error,
  }) {
    return SpecialNoticeState(
      error: error ?? this.error,
    );
  }
}
