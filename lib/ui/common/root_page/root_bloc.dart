import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/authentication.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/user_repository.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  static final log = Log("RootBloc");

  RootBloc(BuildContext context) : super(RootState.initialState);

  final _userRepository = UserRepository();
  final auth = Authentication();
  StreamSubscription _studentSubscription;
  StreamSubscription _lecturesSubscription;

  void _getStudentByEmail(final String email) {
    _studentSubscription?.cancel();
    _studentSubscription = _userRepository
        .query(
          specification: ComplexSpecification(
              [ComplexWhere("nsbmEmail", isEqualTo: email)])
            ..includeMetadataChanges = true,
        )
        .listen((users) =>
            users.length > 0 ? add(CurrentUserChangedEvent(users[0])) : null);
  }

  Stream<RootState> _handleUserLogged(String email) async* {
    if (state.userLogged) {
      return;
    }
    log.d("User logged with email: " + email);
    yield state.clone(userLogged: true);
    _getStudentByEmail(email);
  }

  Stream<RootState> _handleUserChanged(User user) async* {
    final previous = state.currentUser?.ref;
    yield state.clone(currentUser: user);
    log.d("User changed to: " + user.nsbmEmail);
    if (previous != user?.ref) {
      if (user?.role == 'student') {}
      if (user?.role == 'tailor') {}
    }
  }

  Stream<RootState> _handleUserLoggedOut() async* {
    await closeSubscriptions();
    await auth.logout();
    yield RootState.initialState;
  }

  Future<void> closeSubscriptions() async {
    await _studentSubscription?.cancel();
    await _lecturesSubscription?.cancel();
  }

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case UserLoggedEvent:
        final data = event as UserLoggedEvent;
        yield* _handleUserLogged(data?.email);
        break;

      case UserLoggedOutEvent:
        yield* _handleUserLoggedOut();
        break;

      case CurrentUserChangedEvent:
        final user = (event as CurrentUserChangedEvent).user;
        yield* _handleUserChanged(user);
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
