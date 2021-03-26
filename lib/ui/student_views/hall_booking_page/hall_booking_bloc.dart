import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/hall_request_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_event.dart' as r;

import 'hall_booking_event.dart';
import 'hall_booking_state.dart';

class HallBookingBloc extends Bloc<HallBookingEvent, HallBookingState> {
  static final log = Log("HallBookingBloc");

  final hallRequestRepo = HallRequestRepository();
  final RootBloc rootBloc;

  HallBookingBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(HallBookingState.initialState);

  @override
  Stream<HallBookingState> mapEventToState(HallBookingEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case ChangeRoleEvent:
        final value = (event as ChangeRoleEvent).value;
        yield state.clone(type: value);
        break;

      case CreateHallRequestEvent:
        final data = (event as CreateHallRequestEvent);

        final allUsers = rootBloc.state.allLecturers;
        final allHalls = rootBloc.state.allHalls;
        final userName = data.lecturer;
        User lecturer;
        Hall hall;

        if (data.faculty == null || data.faculty.isEmpty) {
          add(ErrorEvent("Please Select Faculty.."));
          break;
        }

        print(data.hall);
        if (data.hall == null || data.hall.isEmpty) {
          add(ErrorEvent("Please Select Hall.."));
          break;
        }

        if (allHalls != null) {
          if (data.hall.isNotEmpty) {
            hall = allHalls.firstWhere(
                (element) => element.hallNumber == int.parse(data.hall));
          }
        }

        if (userName == null || userName.isEmpty) {
          add(ErrorEvent("Please Select Lecturer.."));
          break;
        }

        if (allUsers != null) {
          if (userName.isNotEmpty) {
            lecturer =
                allUsers.firstWhere((element) => element.name == userName);
          }
        }

        final hallBooking = HallRequest(
          type: state.type == 1 ? "Student" : "Club or Organization",
          faculty: data.faculty,
          capacity: data.capacity,
          purpose: data.purpose,
          requestedBy: rootBloc.state.currentUser.ref,
          state: "pending",
          requestedAt: Timestamp.now(),
          hall: hall.ref,
          assigned: lecturer.ref,
          date: data.date,
        );

        yield state.clone(state: HallBookingState.PROCESSING);
        try {
          await hallRequestRepo.add(item: hallBooking);
          yield state.clone(state: HallBookingState.COMPLETE);
          rootBloc.add(r.CreateNotificationEvent(lecturer, "Requested ${data.hall} hall for ${data.purpose}", 0));
        } catch (e) {
          yield state.clone(state: HallBookingState.INITIAL);
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
