import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';

import 'events_event.dart';
import 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  static final log = Log("EventsBloc");

  EventsBloc(BuildContext context) : super(EventsState.initialState);

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
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
