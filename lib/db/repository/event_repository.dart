import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/event.dart';
import 'package:smart_app/util/db_util.dart';

class EventRepository extends FirebaseRepository<Event> {
  @override
  Event fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return Event(
      ref: snapshot.reference,
      title: data[Event.TITLE] ?? "",
      state: data[Event.STATE] ?? "",
      description: data[Event.DESCRIPTION] ?? "",
      imgUrl: data[Event.IMG_URL] ?? "",
      date: data[Event.DATE],
      createdAt: data[Event.CREATED_AT],
      createdBy: data[Event.CREATED_BY],
    );
  }

  @override
  Map<String, dynamic> toMap(Event event) {
    return {
      Event.TITLE: event.title,
      Event.STATE: event.state,
      Event.DESCRIPTION: event.description,
      Event.IMG_URL: event.imgUrl,
      Event.DATE: event.date,
      Event.CREATED_AT: event.createdAt,
      Event.CREATED_BY: event.createdBy,
    };
  }

  @override
  Stream<List<Event>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(specification: specification, type: DBUtil.EVENT);
  }
}
