import 'package:flutter/material.dart';

@immutable
class EventsState {
  final String error;

  EventsState({
    @required this.error,
  });

  static EventsState get initialState => EventsState(
    error: '',
  );

  EventsState clone({
    String error,
  }) {
    return EventsState(
      error: error ?? this.error,
    );
  }
}
