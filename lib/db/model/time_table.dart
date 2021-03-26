import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class TimeTable extends DBModel {
  static const MODULE = 'module';
  static const BATCH = 'batch';
  static const HALL_NUMBER = 'hallNumber';
  static const LECTURER = 'lecturer';
  static const STATE = 'state';
  static const DATE = 'date';
  static const CONTENT = 'content';

  String state;
  String date;
  List<Map> content;

  TimeTable({
    DocumentReference ref,
    this.state,
    this.date,
    this.content,
  }) : super(ref: ref);

  @override
  TimeTable clone({
    DocumentReference ref,
    String state,
    String date,
    List<Map> content,
  }) {
    return TimeTable(
      ref: ref ?? this.ref,
      state: state ?? this.state,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }
}
