import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat_room.dart';

@immutable
class ChatState {
  final String error;
  final String schText;
  final List<ChatRoom> chatRooms;

  ChatState({
    @required this.error,
    @required this.schText,
    @required this.chatRooms,
  });

  static ChatState get initialState => ChatState(
        error: '',
        chatRooms: null,
        schText: '',
      );

  ChatState clone({
    String error,
    String schText,
    List<ChatRoom> chatRooms,
  }) {
    return ChatState(
      error: error ?? this.error,
      chatRooms: chatRooms ?? this.chatRooms,
      schText: schText ?? this.schText,
    );
  }
}
