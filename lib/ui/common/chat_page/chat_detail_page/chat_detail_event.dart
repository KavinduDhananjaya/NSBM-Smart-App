import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat.dart';

@immutable
abstract class ChatDetailEvent {}

class ErrorEvent extends ChatDetailEvent {
  final String error;

  ErrorEvent(this.error);
}

class GetAllChat extends ChatDetailEvent {
  final List<Chat> all;

  GetAllChat(this.all);
}

class CreateMessage extends ChatDetailEvent {
  final String msg;

  CreateMessage(this.msg);
}
