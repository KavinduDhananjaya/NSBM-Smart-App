import 'package:flutter/material.dart' hide Notification;
import 'package:smart_app/db/model/event.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/model/notification.dart';
import 'package:smart_app/db/model/time_table.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
class RootState {
  static const ALL = 0;
  static const PENDING = 1;
  static const ASSIGNED = 2;
  static const REJECT = 3;

  final String error;
  final bool userLogged;
  final User currentUser;
  final List<Event> allEvents;
  final List<Notification> specialNotices;
  final List<Notification> assignedNotifications;
  final List<HallRequest> allHallRequests;
  final List<LectureRequest> allLecturerRequests;
  final List<User> allLecturers;
  final List<Hall> allHalls;
  final int showingType;
  final List<TimeTable> todayTimetable;

  RootState({
    @required this.error,
    @required this.currentUser,
    @required this.userLogged,
    @required this.allEvents,
    @required this.assignedNotifications,
    @required this.specialNotices,
    @required this.allHallRequests,
    @required this.allLecturerRequests,
    @required this.showingType,
    @required this.allLecturers,
    @required this.allHalls,
    @required this.todayTimetable,
  });

  static RootState get initialState => RootState(
        error: '',
        currentUser: null,
        userLogged: false,
        allEvents: null,
        assignedNotifications: null,
        specialNotices: null,
        allHallRequests: null,
        allLecturerRequests: null,
        showingType: ALL,
        allLecturers: [],
        allHalls: [],
        todayTimetable: null,
      );

  RootState clone({
    String error,
    bool userLogged,
    User currentUser,
    List<Event> allEvents,
    List<Notification> specialNotices,
    List<Notification> assignedNotifications,
    List<HallRequest> allHallRequests,
    List<LectureRequest> allLecturerRequests,
    int showingType,
    List<User> allLecturers,
    List<Hall> allHalls,
    List<TimeTable> todayTimetable,
  }) {
    return RootState(
      error: error ?? this.error,
      userLogged: userLogged ?? this.userLogged,
      currentUser: currentUser ?? this.currentUser,
      allEvents: allEvents ?? this.allEvents,
      specialNotices: specialNotices ?? this.specialNotices,
      assignedNotifications: assignedNotifications ?? this.assignedNotifications,
      allHallRequests: allHallRequests ?? this.allHallRequests,
      allLecturerRequests: allLecturerRequests ?? this.allLecturerRequests,
      showingType: showingType ?? this.showingType,
      allLecturers: allLecturers ?? this.allLecturers,
      allHalls: allHalls ?? this.allHalls,
      todayTimetable: todayTimetable ?? this.todayTimetable,
    );
  }
}
