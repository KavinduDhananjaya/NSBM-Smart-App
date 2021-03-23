import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/util/db_util.dart';

class HallRepository extends FirebaseRepository<Hall> {
  @override
  Hall fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;

    try {
      return Hall(
        ref: snapshot.reference,
        faculty: data[Hall.FACULTY] ?? "",
        flow: data[Hall.FLOW] ?? "",
        capacity: data[Hall.CAPACITY],
        hallNumber: data[Hall.HALL_NUMBER],
        isAvailable: data[Hall.IS_AVAILABLE] ?? false,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Map<String, dynamic> toMap(Hall item) {
    return {
      Hall.FACULTY:item.faculty,
      Hall.FLOW:item.flow,
      Hall.HALL_NUMBER:item.hallNumber,
      Hall.CAPACITY:item.capacity,
      Hall.IS_AVAILABLE:item.isAvailable,

    };
  }

  @override
  Future<DocumentReference> update(
      {@required Hall item,
      String type,
      DocumentReference parent,
      MapperCallback<Hall> mapper}) {
    return super.update(
      item: item,
      type: DBUtil.HALL,
      mapper: mapper,
    );
  }

  @override
  Stream<List<Hall>> query(
      {@required SpecificationI specification,
      String type,
      DocumentReference parent}) {
    return super.query(
      specification: specification,
      type: DBUtil.HALL,
    );
  }
}
