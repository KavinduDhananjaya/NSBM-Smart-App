import 'package:flutter/material.dart';

@immutable
class LoginState {
  final String error;

  LoginState({
    @required this.error,
  });

  static LoginState get initialState => LoginState(
    error: '',
  );

  LoginState clone({
    String error,
  }) {
    return LoginState(
      error: error ?? this.error,
    );
  }
}
