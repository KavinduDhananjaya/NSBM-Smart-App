import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_bloc.dart';
import 'chat_view.dart';

class ChatProvider extends BlocProvider<ChatBloc> {
  ChatProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => ChatBloc(context),
          child: ChatView(),
        );
}
