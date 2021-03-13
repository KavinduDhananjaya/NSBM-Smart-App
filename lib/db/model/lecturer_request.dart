import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class LectureRequest extends DBModel {
  static const TYPE = 'type';
  static const PURPOSE = 'purpose';
  static const ASSIGNED = 'assigned';
  static const DATE = 'date';
  static const CONFIRMED_AT = 'confirmedAt';
  static const CONFIRMED_BY = 'confirmedBy';
  static const REQUESTED_AT = 'requestedAt';
  static const REQUESTED_BY = 'requestedBy';
  static const FACULTY = 'faculty';
  static const STATE = 'state';
  static const MESSAGE = 'message';

  String type;
  String purpose;
  DocumentReference assigned;
  Timestamp date;
  Timestamp confirmedAt;
  DocumentReference confirmedBy;
  String faculty;
  String state;
  String message;
  DocumentReference requestedBy;
  Timestamp requestedAt;

  LectureRequest({
    DocumentReference ref,
    this.type,
    this.purpose,
    this.assigned,
    this.date,
    this.confirmedAt,
    this.confirmedBy,
    this.faculty,
    this.state,
    this.message,
    this.requestedBy,
    this.requestedAt,
  }) : super(ref: ref);

  @override
  LectureRequest clone({
    DocumentReference ref,
    String type,
    String purpose,
    DocumentReference assigned,
    Timestamp date,
    Timestamp confirmedAt,
    DocumentReference confirmedBy,
    String faculty,
    String state,
    String message,
    DocumentReference requestedBy,
    Timestamp requestedAt,
  }) {
    return LectureRequest(
      ref: ref ?? this.ref,
      type: type ?? this.type,
      state: state ?? this.state,
      faculty: faculty ?? this.faculty,
      purpose: purpose ?? this.purpose,
      message: message ?? this.message,
      requestedBy: requestedBy ?? this.requestedBy,
      requestedAt: requestedAt ?? this.requestedAt,
      confirmedBy: confirmedBy ?? this.confirmedBy,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      date: date ?? this.date,
      assigned: assigned ?? this.assigned,
    );
  }
}
