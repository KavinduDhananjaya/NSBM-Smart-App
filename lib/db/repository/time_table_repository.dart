import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/time_table.dart';
import 'package:smart_app/util/db_util.dart';

class TimeTableRepository extends FirebaseRepository<TimeTable> {
  @override
  TimeTable fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;

    return TimeTable(
      ref: snapshot.reference,
      state: data[TimeTable.STATE] ?? "",
      date: data[TimeTable.DATE] ?? "",
      content: List<Map>.from(data[TimeTable.CONTENT]),
    );
  }

  @override
  Map<String, dynamic> toMap(TimeTable item) {
    return {};
  }

  @override
  Stream<List<TimeTable>> query(
      {@required SpecificationI specification,
      String type,
      DocumentReference parent}) {
    return super.query(
      specification: specification,
      type: DBUtil.TIMETABLE,
    );
  }
}
