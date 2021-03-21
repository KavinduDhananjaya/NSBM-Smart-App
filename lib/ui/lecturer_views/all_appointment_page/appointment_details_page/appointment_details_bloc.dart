import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/repository/lecturer_request_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'appointment_details_event.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsBloc
    extends Bloc<AppointmentDetailsEvent, AppointmentDetailsState> {
  static final log = Log("LectureAppointmentDetailsBloc");

  final RootBloc rootBloc;
  final repo=LectureRequestRepository();

  AppointmentDetailsBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(AppointmentDetailsState.initialState);

  @override
  Stream<AppointmentDetailsState> mapEventToState(
      AppointmentDetailsEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case ConfirmEvent:
        final req = (event as ConfirmEvent).request;
        final msg = (event as ConfirmEvent).msg;


        try {
          yield state.clone(state: 1);
          await repo.update(
            item: req,
            mapper: (_) => {
              LectureRequest.CONFIRMED_AT: Timestamp.now(),
              LectureRequest.CONFIRMED_BY: rootBloc.state.currentUser.ref,
              LectureRequest.STATE: "assigned",
              LectureRequest.MESSAGE: msg,
            },
          );

          yield state.clone(state: 2);
        } catch (e) {
          print(e);
          yield state.clone(state: 0);
        }

        break;

      case RejectEvent:

        final req = (event as RejectEvent).request;


        try {
          yield state.clone(state: 1);
          await repo.update(
            item: req,
            mapper: (_) => {
              LectureRequest.STATE: "rejected",
            },
          );

          yield state.clone(state: 2);
        } catch (e) {
          print(e);
          yield state.clone(state: 0);
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
