import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/lecturer_request_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart' as r;

import 'lecturer_appointment_event.dart';
import 'lecturer_appointment_state.dart';

class LectureAppointmentBloc
    extends Bloc<LectureAppointmentEvent, LectureAppointmentState> {
  static final log = Log("LectureAppointmentBloc");

  final RootBloc rootBloc;
  final lecturerReqRepo = LectureRequestRepository();

  LectureAppointmentBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(LectureAppointmentState.initialState);

  @override
  Stream<LectureAppointmentState> mapEventToState(
      LectureAppointmentEvent event) async* {
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

      case CreateLecturerRequest:
        final data = (event as CreateLecturerRequest);

        final allUsers = rootBloc.state.allLecturers;
        final userName = data.lecturer;
        User lecturer;

        if(data.faculty==null||data.faculty.isEmpty){
          add(ErrorEvent("Please Select Faculty.."));
          break;
        }

        if (userName == null || userName.isEmpty) {
          add(ErrorEvent("Please Select Lecturer.."));
          break;
        }

        if (allUsers != null) {
          if (userName.isNotEmpty) {
            lecturer = allUsers.firstWhere((element) => element.name == userName);
          }
        }

        final request = LectureRequest(
          type: state.type == 1 ? "Student" : "Club or Organization",
          state: "pending",
          purpose: data.purpose,
          requestedAt: Timestamp.now(),
          date: data.date,
          requestedBy: rootBloc.state.currentUser.ref,
          faculty: data.faculty,
          assigned: lecturer.ref
        );

        yield state.clone(state: LectureAppointmentState.PROCESSING);
        try {
          await lecturerReqRepo.add(item: request);
          yield state.clone(state: LectureAppointmentState.COMPLETE);
          final date = new DateFormat("yyyy-MM-dd").format(data.date.toDate());

          final time = new DateFormat.jm().format(data.date.toDate());

          rootBloc.add(r.CreateNotificationEvent(lecturer.ref, "Requested a Appointment at ${date} ${time}", 0));
        } catch (e) {
          yield state.clone(state: LectureAppointmentState.INITIAL);
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
