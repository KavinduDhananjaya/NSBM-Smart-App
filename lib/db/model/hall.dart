import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Hall extends DBModel {

  static const FACULTY = 'faculty';
  static const FLOW = 'flow';
  static const HALL_NUMBER = 'hallNumber';
  static const CAPACITY = 'capacity';
  static const IS_AVAILABLE = 'isAvailable';

  String faculty;
  String flow;
  int hallNumber;
  int capacity;
  bool isAvailable;

  Hall({
    DocumentReference ref,
    this.faculty,
    this.capacity,
    this.flow,
    this.hallNumber,
    this.isAvailable,
  }) : super(ref: ref);

  @override
  Hall clone({
    DocumentReference ref,
    String faculty,
    String flow,
    int hallNumber,
    int capacity,
    bool isAvailable,
  }) {
    return Hall(
      ref: ref ?? this.ref,
      faculty: faculty ?? this.faculty,
      flow: flow ?? this.flow,
      capacity: capacity ?? this.capacity,
      hallNumber: hallNumber ?? this.hallNumber,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
