import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';

@immutable
abstract class StudentHistoryEvent {}

class ErrorEvent extends StudentHistoryEvent {
  final String error;

  ErrorEvent(this.error);
}

class GetAllHallRequestEvent extends StudentHistoryEvent {
  final List<HallRequest> all;

  GetAllHallRequestEvent(this.all);
}

class GetAllLectureRequestEvent extends StudentHistoryEvent {
  final List<LectureRequest> all;

  GetAllLectureRequestEvent(this.all);
}
