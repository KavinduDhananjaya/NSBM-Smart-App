import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Notification extends DBModel {
  static const TITLE = 'title';
  static const CREATED_AT = 'createdAt';
  static const CREATED_BY = 'createdBy';
  static const TARGET_USER = 'targetUser';
  static const TYPE = 'type';

  static const ALL='all';
  static const ONLY_USER='onlyUser';

  String title;
  String type;
  Timestamp createdAt;
  DocumentReference createdBy;
  DocumentReference targetUser;

  Notification({
    DocumentReference ref,
    this.title,
    this.createdAt,
    this.createdBy,
    this.targetUser,
    this.type,
  }) : super(ref: ref);

  @override
  Notification clone({
    DocumentReference ref,
    String title,
    String type,
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
      type: type ?? this.type,
    );
  }
}
