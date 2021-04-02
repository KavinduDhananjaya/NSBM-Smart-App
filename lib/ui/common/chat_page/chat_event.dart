import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat_room.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
abstract class ChatEvent {}

class ErrorEvent extends ChatEvent {
  final String error;

  ErrorEvent(this.error);
}

class ChangeChatRooms extends ChatEvent {
  final List<ChatRoom> all;

  ChangeChatRooms(this.all);
}

class CreateChatRoom extends ChatEvent {
  final User user;
  CreateChatRoom(this.user);
}
