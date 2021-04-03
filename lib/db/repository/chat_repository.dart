import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_app/db/model/chat.dart';
import 'package:smart_app/util/db_util.dart';

class ChatRepository extends FirebaseRepository<Chat> {
  @override
  Chat fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;

    final data = snapshot.data();

    return Chat(
      ref: snapshot.reference,
      msg: data[Chat.MSG],
      sendBy: data[Chat.SEND_BY],
      time: data[Chat.TIME],
    );
  }

  @override
  Map<String, dynamic> toMap(Chat item) {
    return {
      Chat.MSG: item.msg,
      Chat.SEND_BY: item.sendBy,
      Chat.TIME: item.time,
    };
  }

  @override
  Stream<List<Chat>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super
        .query(specification: specification, type: DBUtil.CHAT, parent: parent);
  }

  @override
  Future<DocumentReference> add({
    @required Chat item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.CHAT, parent: parent);
  }
}
