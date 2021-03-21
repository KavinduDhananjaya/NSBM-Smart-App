import 'package:flutter/material.dart';

@immutable
class MapState {
  final String error;

  MapState({
    @required this.error,
  });

  static MapState get initialState => MapState(
    error: '',
  );

  MapState clone({
    String error,
  }) {
    return MapState(
      error: error ?? this.error,
    );
  }
}
