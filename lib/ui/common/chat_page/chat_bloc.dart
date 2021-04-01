import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/repository/chat_room_repository.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static final log = Log("ChatBloc");

  final RootBloc rootBloc;
  final repo = ChatRoomRepository();
  StreamSubscription chatRoomSubscription;

  ChatBloc(BuildContext context)
      : rootBloc = BlocProvider.of<RootBloc>(context),
        super(ChatState.initialState) {
    _getAllChatRooms();
  }

  void _getAllChatRooms() {
    chatRoomSubscription?.cancel();
    chatRoomSubscription = repo
        .query(
            specification: ComplexSpecification([
      ComplexWhere('users', arrayContainsAny: [rootBloc.state?.currentUser?.ref])
    ]))
        .listen((event) {
      add(ChangeChatRooms(event));
    });
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case ChangeChatRooms:
        final all = (event as ChangeChatRooms).all;
        yield state.clone(chatRooms: all);
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
    chatRoomSubscription?.cancel();
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
