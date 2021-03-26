import 'package:flutter/material.dart';

@immutable
class ChatDetailState {
  final String error;

  ChatDetailState({
    @required this.error,
  });

  static ChatDetailState get initialState => ChatDetailState(
    error: '',
  );

  ChatDetailState clone({
    String error,
  }) {
    return ChatDetailState(
      error: error ?? this.error,
    );
  }
}
