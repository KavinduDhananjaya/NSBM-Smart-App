import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent {}

class ErrorEvent extends LoginEvent {
  final String error;

  ErrorEvent(this.error);
}

class LoginClickEvent extends LoginEvent {
  final String email;
  final String password;

  LoginClickEvent(this.email, this.password);
}