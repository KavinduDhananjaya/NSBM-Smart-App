import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/authentication.dart';
import 'package:smart_app/db/repository/user_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final log = Log("LoginBloc");

  final _authentication = Authentication();
  final _userRepository = UserRepository();

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }


  LoginBloc(BuildContext context) : super(LoginState.initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case LoginClickEvent:
        try {
          final data = event as LoginClickEvent;

          if (isValidEmail(data.email)) {

            final fetchEmail = await FirebaseAuth.instance
                .fetchSignInMethodsForEmail(data.email);

            if (fetchEmail.isEmpty) {
              add(ErrorEvent("User does not exist.Please SignUp."));
              break;
            }

            final email = await _authentication.login(data.email, data.password);

            if (email.isNotEmpty) {
              yield state.clone(email: email, error: "");
            }

            break;
          } else {
            add(ErrorEvent("Invalid Email...Please Try Again"));
            break;
          }
        } catch (e) {
          try {
            add(ErrorEvent((e is String)
                ? e
                : (e.message ?? "Something went wrong. Please try again !")));
          } catch (e) {
            add(ErrorEvent("Something went wrong. Please try again !"));
          }
        }
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.e('$stacktrace');
    log.e('$error');
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
