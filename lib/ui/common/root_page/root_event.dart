import 'package:flutter/material.dart' hide Notification;
import 'package:smart_app/db/model/event.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/db/model/notification.dart';
import 'package:smart_app/db/model/user.dart';

@immutable
abstract class RootEvent {}

class ErrorEvent extends RootEvent {
  final String error;

  ErrorEvent(this.error);
}

class UserLoggedEvent extends RootEvent {
  final String email;

  UserLoggedEvent(
    this.email,
  );
}

class UserLoggedOutEvent implements RootEvent {}

class CurrentUserChangedEvent implements RootEvent {
  final User user;

  CurrentUserChangedEvent(this.user);
}

class ChangeAllEvents extends RootEvent {
  final List<Event> all;

  ChangeAllEvents(this.all);
}

class ChangeAllSpecialNotice extends RootEvent {
  final List<Notification> all;

  ChangeAllSpecialNotice(this.all);
}

class ChangeAllNotification extends RootEvent {
  final List<Notification> all;

  ChangeAllNotification(this.all);
}

class ChangeAllHallRequests extends RootEvent {
  final List<HallRequest> all;

  ChangeAllHallRequests(this.all);
}

class ChangeAllLecturerRequests extends RootEvent {
  final List<LectureRequest> all;

  ChangeAllLecturerRequests(this.all);
}

class ChangeShowingType extends RootEvent {
  final int type;

  ChangeShowingType(this.type);
}
