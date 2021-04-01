import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat_room.dart';

@immutable
class ChatState {
  final String error;
  final List<ChatRoom> chatRooms;

  ChatState({
    @required this.error,
    @required this.chatRooms,
  });

  static ChatState get initialState => ChatState(
        error: '',
        chatRooms: null,
      );

  ChatState clone({
    String error,
    List<ChatRoom> chatRooms,
  }) {
    return ChatState(
      error: error ?? this.error,
      chatRooms: chatRooms ?? this.chatRooms,
    );
  }
}
