import 'package:flutter/material.dart';

@immutable
class ChatState {
  final String error;

  ChatState({
    @required this.error,
  });

  static ChatState get initialState => ChatState(
    error: '',
  );

  ChatState clone({
    String error,
  }) {
    return ChatState(
      error: error ?? this.error,
    );
  }
}
