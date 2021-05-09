import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/util/db_util.dart';

class HallRequestRepository extends FirebaseRepository<HallRequest> {
  @override
  HallRequest fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return HallRequest(
      ref: snapshot.reference,
      type: data[HallRequest.TYPE] ?? "",
      state: data[HallRequest.STATE] ?? "",
      adminState: data[HallRequest.ADMIN_STATE] ?? "",
      purpose: data[HallRequest.PURPOSE] ?? "",
      faculty: data[HallRequest.FACULTY] ?? "",
      hall: data[HallRequest.HALL],
      assigned: data[HallRequest.ASSIGNED],
      date: data[HallRequest.DATE],
      capacity: data[HallRequest.CAPACITY],
      confirmedAt: data[HallRequest.CONFIRMED_AT],
      confirmedBy: data[HallRequest.CONFIRMED_BY],
      requestedBy: data[HallRequest.REQUESTED_BY],
      requestedAt: data[HallRequest.REQUESTED_AT],
    );
  }

  @override
  Map<String, dynamic> toMap(HallRequest request) {
    return {
      HallRequest.TYPE: request.type,
      HallRequest.DATE: request.date,
      HallRequest.CAPACITY: request.capacity,
      HallRequest.CONFIRMED_AT: request.confirmedAt,
      HallRequest.CONFIRMED_BY: request.confirmedBy,
      HallRequest.REQUESTED_BY: request.requestedBy,
      HallRequest.REQUESTED_AT: request.requestedAt,
      HallRequest.ASSIGNED: request.assigned,
      HallRequest.HALL: request.hall,
      HallRequest.FACULTY: request.faculty,
      HallRequest.PURPOSE: request.purpose,
      HallRequest.STATE: request.state,
      HallRequest.ADMIN_STATE: request.adminState,
    };
  }

  @override
  Stream<List<HallRequest>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(specification: specification, type: DBUtil.HALL_REQUEST);
  }

  @override
  Future<DocumentReference> update({
    @required HallRequest item,
    String type,
    DocumentReference parent,
    MapperCallback<HallRequest> mapper,
  }) {
    return super.update(
      item: item,
      type: DBUtil.HALL_REQUEST,
      mapper: mapper,
    );
  }

  @override
  Future<DocumentReference> add({
    @required HallRequest item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.HALL_REQUEST);
  }
}
