import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class ChatRoom extends DBModel {
  List<DocumentReference> users;

  ChatRoom({
    DocumentReference ref,
    this.users,
  }) : super(ref: ref);

  @override
  ChatRoom clone({
    DocumentReference ref,
    List<DocumentReference> users,
  }) {
    return ChatRoom(
      ref: ref ?? this.ref,
      users: users ?? this.users,
    );
  }
}
