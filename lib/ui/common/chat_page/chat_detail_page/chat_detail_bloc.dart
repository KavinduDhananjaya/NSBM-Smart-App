import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/chat.dart';
import 'package:smart_app/db/model/chat_room.dart';
import 'package:smart_app/db/repository/chat_repository.dart';
import 'package:smart_app/db/repository/chat_room_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'chat_detail_event.dart';
import 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  static final log = Log("ChatDetailBloc");

  final RootBloc rootBloc;
  final ChatRoom chtRoom;
  final repo = ChatRepository();
  final chatRoomRepo = ChatRoomRepository();

  StreamSubscription chatSubscription;

  ChatDetailBloc(BuildContext context, this.chtRoom)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(ChatDetailState.initialState) {
    getAllChats(chtRoom.ref);
  }

  void getAllChats(DocumentReference ref) {
    chatSubscription?.cancel();
    chatSubscription = repo
        .query(
            specification: ComplexSpecification(
              [OrderBy("time")],
            ),
            parent: ref)
        .listen((event) {
      add(GetAllChat(event));
    });
  }

  @override
  Stream<ChatDetailState> mapEventToState(ChatDetailEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case GetAllChat:
        final all = (event as GetAllChat).all;
        yield state.clone(allChat: all);
        break;

      case CreateMessage:
        final msgText = (event as CreateMessage).msg;

        final msg = Chat(
          msg: msgText,
          time: Timestamp.now(),
          sendBy: rootBloc.state.currentUser.ref,
        );

        try {
          await repo.add(item: msg, parent: chtRoom.ref);

          await chatRoomRepo.update(
              item: chtRoom,
              mapper: (_) => {
                    ChatRoom.LAST_MESSAGE: msgText,
                  });
        } catch (e) {
          print(e.toString());
        }

        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.e('$stacktrace');
    log.e('$error');
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    chatSubscription?.cancel();
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
