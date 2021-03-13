import 'package:flutter/material.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
abstract class RootEvent {}

class ErrorEvent extends RootEvent {
  final String error;

  ErrorEvent(this.error);
}

class UserLoggedEvent extends RootEvent {
  final String email;

  UserLoggedEvent(
      this.email,
      );
}

class UserLoggedOutEvent implements RootEvent {}

class CurrentUserChangedEvent implements RootEvent {
  final User user;

  CurrentUserChangedEvent(this.user);
}