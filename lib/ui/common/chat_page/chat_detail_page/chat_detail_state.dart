import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat.dart';

@immutable
class ChatDetailState {
  final String error;
  final List<Chat> allChat;

  ChatDetailState({
    @required this.error,
    @required this.allChat,
  });

  static ChatDetailState get initialState => ChatDetailState(
        error: '',
        allChat: null,
      );

  ChatDetailState clone({
    String error,
    List<Chat> allChat,
  }) {
    return ChatDetailState(
      error: error ?? this.error,
      allChat: allChat ?? this.allChat,
    );
  }
}
