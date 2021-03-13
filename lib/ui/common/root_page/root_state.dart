import 'package:flutter/material.dart' hide Notification;
import 'package:smart_app/db/model/event.dart';
import 'package:smart_app/db/model/notification.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
class RootState {
  final String error;
  final bool userLogged;
  final User currentUser;
  final List<Event> allEvents;
  final List<Notification> specialNotices;
  final List<Notification> assignedNotifications;

  RootState({
    @required this.error,
    @required this.currentUser,
    @required this.userLogged,
    @required this.allEvents,
    @required this.assignedNotifications,
    @required this.specialNotices,
  });

  static RootState get initialState => RootState(
        error: '',
        currentUser: null,
        userLogged: false,
        allEvents: null,
        assignedNotifications: null,
        specialNotices: null,
      );

  RootState clone({
    String error,
    bool userLogged,
    User currentUser,
    List<Event> allEvents,
    List<Notification> specialNotices,
    List<Notification> assignedNotifications,
  }) {
    return RootState(
      error: error ?? this.error,
      userLogged: userLogged ?? this.userLogged,
      currentUser: currentUser ?? this.currentUser,
      allEvents: allEvents ?? this.allEvents,
      specialNotices: specialNotices ?? this.specialNotices,
      assignedNotifications:
          assignedNotifications ?? this.assignedNotifications,
    );
  }
}
