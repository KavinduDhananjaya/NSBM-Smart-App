import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_app/db/model/chat_room.dart';
import 'package:smart_app/util/db_util.dart';

class ChatRoomRepository extends FirebaseRepository<ChatRoom> {
  @override
  ChatRoom fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();

    if (data == null) return null;

    return ChatRoom(
      ref: snapshot.reference,
      users: List.from(
        data['users'] ?? [],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap(ChatRoom item) {
    return {
      'users': item.users,
    };
  }

  @override
  Stream<List<ChatRoom>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(specification: specification, type: DBUtil.CHAT_ROOM);
  }

  @override
  Future<DocumentReference> add({
    @required ChatRoom item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.CHAT_ROOM);
  }
}
