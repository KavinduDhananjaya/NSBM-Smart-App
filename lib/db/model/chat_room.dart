import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class ChatRoom extends DBModel {

  static const USERS='users';
  static const LAST_MESSAGE='lastMsg';
  static const LAST_MESSAGE_AT='lastMsgAt';

  List<DocumentReference> users;
  String lastMsg;
  Timestamp lastMsgAt;

  ChatRoom({
    DocumentReference ref,
    this.users,
    this.lastMsg,
    this.lastMsgAt,
  }) : super(ref: ref);

  @override
  ChatRoom clone({
    DocumentReference ref,
    List<DocumentReference> users,
    String lastMsg,
    Timestamp lastMsgAt,
  }) {
    return ChatRoom(
      ref: ref ?? this.ref,
      users: users ?? this.users,
      lastMsg: lastMsg ?? this.lastMsg,
      lastMsgAt: lastMsgAt ?? this.lastMsgAt,
    );
  }
}
