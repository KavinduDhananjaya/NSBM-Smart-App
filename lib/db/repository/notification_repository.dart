import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:smart_app/db/model/notification.dart';
import 'package:smart_app/util/db_util.dart';

class NotificationRepository extends FirebaseRepository<Notification> {
  @override
  Notification fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return Notification(
      ref: snapshot.reference,
      title: data[Notification.TITLE] ?? "",
      createdAt: data[Notification.CREATED_AT],
      createdBy: data[Notification.CREATED_BY],
      targetUser: data[Notification.TARGET_USER],
    );
  }

  @override
  Map<String, dynamic> toMap(Notification item) {
    return {
      Notification.TITLE: item.title,
      Notification.CREATED_BY: item.createdBy,
      Notification.CREATED_AT: item.createdAt,
      Notification.TARGET_USER: item.targetUser,
    };
  }

  @override
  Stream<List<Notification>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.NOTIFICATION,
    );
  }

  @override
  Future<DocumentReference> add({
    @required Notification item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(
      item: item,
      type: DBUtil.NOTIFICATION,
    );
  }
}
