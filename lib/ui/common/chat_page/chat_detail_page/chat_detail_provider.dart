import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/chat_room.dart';

import 'chat_detail_bloc.dart';
import 'chat_detail_view.dart';

class ChatDetailProvider extends BlocProvider<ChatDetailBloc> {
  ChatDetailProvider({
    Key key,
    ChatRoom chatRoom,
    DocumentReference user,
  }) : super(
          key: key,
          create: (context) => ChatDetailBloc(context, chatRoom),
          child: ChatDetailView(
            user: user,
          ),
        );
}
