import 'package:flutter/material.dart';
import 'package:smart_app/db/model/lecturer_request.dart';

@immutable
abstract class AppointmentDetailsEvent {}

class ErrorEvent extends AppointmentDetailsEvent {
  final String error;

  ErrorEvent(this.error);
}

class ConfirmEvent extends AppointmentDetailsEvent{
  final LectureRequest request;
  final String msg;

  ConfirmEvent(this.request,this.msg);
}


class RejectEvent extends AppointmentDetailsEvent{
  final LectureRequest request;

  RejectEvent(this.request);
}
