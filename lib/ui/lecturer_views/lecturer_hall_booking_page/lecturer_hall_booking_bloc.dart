import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';

import 'lecturer_hall_booking_event.dart';
import 'lecturer_hall_booking_state.dart';

class LecturerHallBookingBloc extends Bloc<LecturerHallBookingEvent, LecturerHallBookingState> {
  static final log = Log("LectureHallBookingBloc");

  LecturerHallBookingBloc(BuildContext context) : super(LecturerHallBookingState.initialState);

  @override
  Stream<LecturerHallBookingState> mapEventToState(LecturerHallBookingEvent event) async* {
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
