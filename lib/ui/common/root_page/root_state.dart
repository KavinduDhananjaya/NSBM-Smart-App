import 'package:flutter/material.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
class RootState {
  final String error;
  final bool userLogged;
  final User currentUser;

  RootState({
    @required this.error,
    @required this.currentUser,
    @required this.userLogged,
  });

  static RootState get initialState => RootState(
        error: '',
        currentUser: null,
        userLogged: false,
      );

  RootState clone({
    String error,
    bool userLogged,
    User currentUser,
  }) {
    return RootState(
      error: error ?? this.error,
      userLogged: userLogged ?? this.userLogged,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
