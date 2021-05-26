import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:smart_app/db/authentication.dart';
import 'package:smart_app/db/model/event.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/model/notification.dart';
import 'package:smart_app/db/model/time_table.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/event_repository.dart';
import 'package:smart_app/db/repository/hall_repository.dart';
import 'package:smart_app/db/repository/hall_request_repository.dart';
import 'package:smart_app/db/repository/lecturer_request_repository.dart';
import 'package:smart_app/db/repository/notification_repository.dart';
import 'package:smart_app/db/repository/time_table_repository.dart';
import 'package:smart_app/db/repository/user_repository.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  static final log = Log("RootBloc");

  RootBloc(BuildContext context) : super(RootState.initialState);

  final today = new DateFormat("yyyy-MM-dd").format(DateTime.now());

  final _userRepository = UserRepository();
  final _eventRepository = EventRepository();
  final _notificationRepository = NotificationRepository();
  final _lecturerRequestRepository = LectureRequestRepository();
  final _hallRequestRepository = HallRequestRepository();
  final _hallRepository = HallRepository();
  final _timeTableRepository = TimeTableRepository();

  final auth = Authentication();
  StreamSubscription _studentSubscription;
  StreamSubscription _lecturesSubscription;
  StreamSubscription _eventsSubscription;
  StreamSubscription _notificationSubscription;
  StreamSubscription _assignedNotificationSubscription;
  StreamSubscription _lecturerRequestSubscription;
  StreamSubscription _hallRequestSubscription;
  StreamSubscription _hallSubscription;
  StreamSubscription _timetableSubscription;

  void _getUserByEmail(final String email) {
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

  void _getAllEvents() {
    _eventsSubscription?.cancel();
    _eventsSubscription = _eventRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(Event.STATE, isEqualTo: "upComing")]))
        .listen((event) {
      add(ChangeAllEvents(event));
    });
  }

  void _getSpecialNotifications() {
    _notificationSubscription?.cancel();
    _notificationSubscription = _notificationRepository
        .query(
      specification: ComplexSpecification(
          [ComplexWhere(Notification.TYPE, isEqualTo: Notification.ALL)]),
    )
        .listen((event) {
      add(ChangeAllSpecialNotice(event));
    });
  }

  void _getAllAssignedNotifications(User user) {
    _assignedNotificationSubscription?.cancel();
    _assignedNotificationSubscription = _notificationRepository
        .query(
      specification: ComplexSpecification(
          [ComplexWhere(Notification.TARGET_USER, isEqualTo: user.ref)]),
    )
        .listen((event) {
      add(ChangeAllNotification(event));
    });
  }

  void _getAllHallRequest(User user) {
    _hallRequestSubscription?.cancel();
    _hallRequestSubscription = _hallRequestRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(HallRequest.ASSIGNED, isEqualTo: user.ref)]))
        .listen((event) {
      add(ChangeAllHallRequests(event));
    });
  }

  void _getAllLecturerRequest(User user) {
    _lecturerRequestSubscription?.cancel();
    _lecturerRequestSubscription = _lecturerRequestRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(LectureRequest.ASSIGNED, isEqualTo: user.ref)]))
        .listen((event) {
      add(ChangeAllLecturerRequests(event));
    });
  }

  void _getAllLectures() {
    _lecturesSubscription?.cancel();
    _lecturesSubscription = _userRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(User.ROLE_FIELD, isEqualTo: "lecturer")]))
        .listen((event) {
          print(event);
      add(ChangeAllLecturersEvent(event));
    });
  }

  void _getAllHalls() {
    _hallSubscription?.cancel();
    _hallSubscription = _hallRepository
        .query(
            specification: ComplexSpecification(
                [ComplexWhere(Hall.IS_AVAILABLE, isEqualTo: true)]))
        .listen((event) {
      add(ChangeAllHallsEvent(event));
    });
  }

  void _getTodayTimeTable() {
    _timetableSubscription?.cancel();
    _timeTableRepository
        .query(
            specification: ComplexSpecification([]))
        .listen((event) {
      if (event.length > 0) {

        add(ChangeTodayTimetable(event));
      }
    });
  }

  Stream<RootState> _handleUserLogged(String email) async* {
    if (state.userLogged) {
      return;
    }
    log.d("User logged with email: " + email);
    yield state.clone(userLogged: true);
    _getUserByEmail(email);
  }

  Stream<RootState> _handleUserChanged(User user) async* {
    final previous = state.currentUser?.ref;
    yield state.clone(currentUser: user);
    log.d("User changed to: " + user.nsbmEmail);
    if (previous != user?.ref) {
      _getAllAssignedNotifications(user);
      _getAllLectures();
      _getAllHalls();
      _getTodayTimeTable();
      if (user?.role == 'student') {
        _getAllEvents();
        _getSpecialNotifications();
      }
      if (user?.role == 'lecturer') {
        _getAllHallRequest(user);
        _getAllLecturerRequest(user);
      }
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
    await _notificationSubscription?.cancel();
    await _assignedNotificationSubscription?.cancel();
    await _lecturerRequestSubscription?.cancel();
    await _eventsSubscription?.cancel();
    await _hallSubscription?.cancel();
    await _timetableSubscription?.cancel();
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

      case ChangeTodayTimetable:
        final data = (event as ChangeTodayTimetable).data;

        if (data != null) {
          yield state.clone(todayTimetable: data);
        }

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

      case ChangeAllEvents:
        final all = (event as ChangeAllEvents).all;
        yield state.clone(allEvents: all);
        break;

      case ChangeAllNotification:
        final all = (event as ChangeAllNotification).all;
        yield state.clone(assignedNotifications: all);
        break;

      case ChangeAllSpecialNotice:
        final all = (event as ChangeAllSpecialNotice).all;
        yield state.clone(specialNotices: all);
        break;

      case ChangeAllHallRequests:
        final all = (event as ChangeAllHallRequests).all;
        yield state.clone(allHallRequests: all);
        break;

      case ChangeAllLecturerRequests:
        final all = (event as ChangeAllLecturerRequests).all;
        yield state.clone(allLecturerRequests: all);
        break;

      case ChangeShowingType:
        final type = (event as ChangeShowingType).type;
        yield state.clone(showingType: type);
        break;

      case CreateNotificationEvent:
        final data = (event as CreateNotificationEvent);

        final notification = Notification(
          title: data.title,
          type: data.type == 0 ? "onlyUser" : "all",
          createdBy: state.currentUser.ref,
          createdAt: Timestamp.now(),
          targetUser: data.assigned,
        );

        try {
          await _notificationRepository.add(item: notification);
        } catch (e) {
          print(e);
        }

        break;

      case ChangeAllLecturersEvent:
        yield state.clone(allLecturers: (event as ChangeAllLecturersEvent).all);
        break;

      case ChangeAllHallsEvent:
        yield state.clone(allHalls: (event as ChangeAllHallsEvent).all);
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
