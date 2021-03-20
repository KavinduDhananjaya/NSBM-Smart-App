import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HallBookingEvent {}

class ErrorEvent extends HallBookingEvent {
  final String error;

  ErrorEvent(this.error);
}

class CreateHallRequestEvent extends HallBookingEvent {
  final String purpose;
  final String faculty;
  final int capacity;
  final Timestamp date;
  final String hall;
  final String lecturer;

  CreateHallRequestEvent({
    this.hall,
    this.purpose,
    this.faculty,
    this.capacity,
    this.date,
    this.lecturer,
  });
}

class ChangeRoleEvent extends HallBookingEvent {
  final int value;

  ChangeRoleEvent(this.value);
}
