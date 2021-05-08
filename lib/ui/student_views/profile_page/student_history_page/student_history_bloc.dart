import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/hall_request_repository.dart';
import 'package:smart_app/db/repository/lecturer_request_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'student_history_event.dart';
import 'student_history_state.dart';

class StudentHistoryBloc
    extends Bloc<StudentHistoryEvent, StudentHistoryState> {
  static final log = Log("StudentHistoryBloc");

  final _lecturerRequestRepository = LectureRequestRepository();
  final _hallRequestRepository = HallRequestRepository();

  StreamSubscription _lecturerRequestSubscription;
  StreamSubscription _hallRequestSubscription;

  final RootBloc rootBloc;

  Future<void> closeSubscriptions() async {
    await _lecturerRequestSubscription?.cancel();
    await _hallRequestSubscription?.cancel();
  }

  StudentHistoryBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(StudentHistoryState.initialState) {
    _getAllHallRequest(rootBloc.state?.currentUser);
    _getAllLecturerRequest(rootBloc.state?.currentUser);
  }

  void _getAllHallRequest(User user) {
    _hallRequestSubscription?.cancel();
    _hallRequestSubscription = _hallRequestRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(HallRequest.REQUESTED_BY, isEqualTo: user.ref)]))
        .listen((event) {
      add(GetAllHallRequestEvent(event));
    });
  }

  void _getAllLecturerRequest(User user) {
    _lecturerRequestSubscription?.cancel();
    _lecturerRequestSubscription = _lecturerRequestRepository
        .query(
            specification: ComplexSpecification([
      ComplexWhere(LectureRequest.REQUESTED_BY, isEqualTo: user.ref)
    ]))
        .listen((event) {
      add(GetAllLectureRequestEvent(event));
    });
  }

  @override
  Stream<StudentHistoryState> mapEventToState(
      StudentHistoryEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case GetAllLectureRequestEvent:
        final all=(event as GetAllLectureRequestEvent).all;
        yield state.clone(allLecturerRequests: all);
        break;

      case GetAllHallRequestEvent:
        final all=(event as GetAllHallRequestEvent).all;
        yield state.clone(allHallRequests: all);
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
    await closeSubscriptions();
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
