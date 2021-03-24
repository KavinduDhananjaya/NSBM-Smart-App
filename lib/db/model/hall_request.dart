import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class HallRequest extends DBModel {
  static const TYPE = 'type';
  static const PURPOSE = 'purpose';
  static const CAPACITY = 'capacity';
  static const ASSIGNED = 'assigned';
  static const DATE = 'date';
  static const CONFIRMED_AT = 'confirmedAt';
  static const CONFIRMED_BY = 'confirmedBy';
  static const REQUESTED_AT = 'requestedAt';
  static const REQUESTED_BY = 'requestedBy';
  static const HALL = 'hall';
  static const FACULTY = 'faculty';
  static const STATE = 'state';

  String type;
  String purpose;
  int capacity;
  DocumentReference assigned;
  Timestamp date;
  Timestamp confirmedAt;
  DocumentReference confirmedBy;
  Timestamp requestedAt;
  DocumentReference requestedBy;
  DocumentReference hall;
  String faculty;
  String state;

  HallRequest({
    DocumentReference ref,
    this.type,
    this.purpose,
    this.capacity,
    this.assigned,
    this.date,
    this.confirmedAt,
    this.confirmedBy,
    this.requestedAt,
    this.requestedBy,
    this.hall,
    this.faculty,
    this.state,
  }) : super(ref: ref);

  @override
  HallRequest clone({
    DocumentReference ref,
    String type,
    String purpose,
    int capacity,
    DocumentReference assigned,
    Timestamp date,
    Timestamp confirmedAt,
    DocumentReference confirmedBy,
    Timestamp requestedAt,
    DocumentReference requestedBy,
    DocumentReference hall,
    String faculty,
    String state,
  }) {
    return HallRequest(
      ref: ref ?? this.ref,
      type: type ?? this.type,
      state: state ?? this.state,
      hall: hall ?? this.hall,
      purpose: purpose ?? this.purpose,
      capacity: capacity ?? this.capacity,
      faculty: faculty ?? this.faculty,
      assigned: assigned ?? this.assigned,
      date: date ?? this.date,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      confirmedBy: confirmedBy ?? this.confirmedBy,
      requestedAt: requestedAt ?? this.requestedAt,
      requestedBy: requestedBy ?? this.requestedBy,
    );
  }
}
