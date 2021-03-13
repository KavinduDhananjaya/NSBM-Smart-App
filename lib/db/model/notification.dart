import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Notification extends DBModel {
  String title;
  Timestamp createdAt;
  DocumentReference createdBy;
  DocumentReference targetUser;

  Notification({
    DocumentReference ref,
    this.title,
    this.createdAt,
    this.createdBy,
    this.targetUser,
  }) : super(ref: ref);

  @override
  Notification clone({
    DocumentReference ref,
    String title,
    Timestamp createdAt,
    DocumentReference createdBy,
    DocumentReference targetUser,
  }) {
    return Notification(
      ref: ref ?? this.ref,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      targetUser: targetUser ?? this.targetUser,
    );
  }
}
