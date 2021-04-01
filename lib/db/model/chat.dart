import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Chat extends DBModel {
  static const MSG = 'msg';
  static const SEND_BY = 'sendBy';
  static const TIME = 'time';

  String msg;
  DocumentReference sendBy;
  Timestamp time;

  Chat({
    DocumentReference ref,
    this.msg,
    this.sendBy,
    this.time,
  }) : super(ref: ref);

  @override
  Chat clone({
    DocumentReference ref,
    String msg,
    DocumentReference sendBy,
    Timestamp time,
  }) {
    return Chat(
      ref: ref ?? this.ref,
      msg: msg ?? this.msg,
      sendBy: sendBy ?? this.sendBy,
      time: time ?? this.time,
    );
  }
}
