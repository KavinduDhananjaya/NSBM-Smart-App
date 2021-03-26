import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_detail_bloc.dart';
import 'chat_detail_view.dart';

class ChatDetailProvider extends BlocProvider<ChatDetailBloc> {
  ChatDetailProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => ChatDetailBloc(context),
          child: ChatDetailView(),
        );
}
