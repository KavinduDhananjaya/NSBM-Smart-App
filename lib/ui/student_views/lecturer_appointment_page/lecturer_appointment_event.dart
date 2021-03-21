import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LectureAppointmentEvent {}

class ErrorEvent extends LectureAppointmentEvent {
  final String error;

  ErrorEvent(this.error);
}

class ChangeRoleEvent extends LectureAppointmentEvent {
  final int value;

  ChangeRoleEvent(this.value);
}

class CreateLecturerRequest extends LectureAppointmentEvent {
  final String purpose;
  final String faculty;
  final Timestamp date;
  final String lecturer;

  CreateLecturerRequest({this.purpose, this.faculty, this.date, this.lecturer});
}
