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
        users: List.from(data[ChatRoom.USERS] ?? []),
        lastMsg: data[ChatRoom.LAST_MESSAGE] ?? '',
        lastMsgAt: data[ChatRoom.LAST_MESSAGE_AT]);
  }

  @override
  Map<String, dynamic> toMap(ChatRoom item) {
    return {
      ChatRoom.USERS: item.users,
      ChatRoom.LAST_MESSAGE: item.lastMsg,
      ChatRoom.LAST_MESSAGE_AT: item.lastMsgAt,
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

  @override
  Future<DocumentReference> update({
    @required ChatRoom item,
    String type,
    DocumentReference parent,
    MapperCallback<ChatRoom> mapper,
  }) {
    return super.update(item: item, type: DBUtil.CHAT_ROOM, mapper: mapper);
  }

  @override
  Future<Function> remove({@required ChatRoom item}) {
    return super.remove(item: item);
  }
}
