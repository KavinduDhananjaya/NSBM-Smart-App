import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/util/db_util.dart';

class LectureRequestRepository extends FirebaseRepository<LectureRequest> {
  @override
  LectureRequest fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return LectureRequest(
      ref: snapshot.reference,
      type: data[LectureRequest.TYPE] ?? "",
      state: data[LectureRequest.STATE] ?? "",
      faculty: data[LectureRequest.FACULTY] ?? "",
      purpose: data[LectureRequest.PURPOSE] ?? "",
      message: data[LectureRequest.MESSAGE] ?? "",
      assigned: data[LectureRequest.ASSIGNED],
      confirmedAt: data[LectureRequest.CONFIRMED_AT],
      date: data[LectureRequest.DATE],
      requestedAt: data[LectureRequest.REQUESTED_AT],
      requestedBy: data[LectureRequest.REQUESTED_BY],
      confirmedBy: data[LectureRequest.CONFIRMED_BY],
    );
  }

  @override
  Map<String, dynamic> toMap(LectureRequest item) {
    return {
      LectureRequest.TYPE: item.type,
      LectureRequest.STATE: item.state,
      LectureRequest.CONFIRMED_AT: item.confirmedAt,
      LectureRequest.ASSIGNED: item.assigned,
      LectureRequest.FACULTY: item.faculty,
      LectureRequest.PURPOSE: item.purpose,
      LectureRequest.MESSAGE: item.message,
      LectureRequest.CONFIRMED_BY: item.confirmedAt,
      LectureRequest.DATE: item.date,
      LectureRequest.REQUESTED_AT: item.requestedAt,
      LectureRequest.REQUESTED_BY: item.requestedBy,
    };
  }

  @override
  Stream<List<LectureRequest>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.LECTURER_REQUEST,
    );
  }

  @override
  Future<DocumentReference> update({
    @required LectureRequest item,
    String type,
    DocumentReference parent,
    MapperCallback<LectureRequest> mapper,
  }) {
    return super
        .update(item: item, type: DBUtil.LECTURER_REQUEST, mapper: mapper);
  }

  @override
  Future<DocumentReference> add({
    @required LectureRequest item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.LECTURER_REQUEST,
    );
  }
}
