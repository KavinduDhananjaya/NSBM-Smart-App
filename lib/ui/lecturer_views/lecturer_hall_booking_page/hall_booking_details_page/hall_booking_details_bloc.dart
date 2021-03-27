import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/repository/hall_request_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_event.dart' as r;

import 'hall_booking_details_event.dart';
import 'hall_booking_details_state.dart';

class HallBookingDetailsBloc
    extends Bloc<HallBookingDetailsEvent, HallBookingDetailsState> {
  static final log = Log("HallBookingDetailsBloc");

  final RootBloc rootBloc;
  final repo = HallRequestRepository();

  HallBookingDetailsBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(HallBookingDetailsState.initialState);

  @override
  Stream<HallBookingDetailsState> mapEventToState(
      HallBookingDetailsEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case ConfirmEvent:
        final req = (event as ConfirmEvent).request;


        try {
          yield state.clone(state: 1);
          await repo.update(
            item: req,
            mapper: (_) => {
              HallRequest.CONFIRMED_AT: Timestamp.now(),
              HallRequest.CONFIRMED_BY: rootBloc.state.currentUser.ref,
              HallRequest.STATE: "assigned",
            },
          );

          rootBloc.add(r.CreateNotificationEvent(req.requestedBy, "Your Hall Request is Confirmed", 0));

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
              HallRequest.STATE: "rejected",
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
