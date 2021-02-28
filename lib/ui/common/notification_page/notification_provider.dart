import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_bloc.dart';
import 'notification_view.dart';

class NotificationProvider extends BlocProvider<NotificationBloc> {
  NotificationProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => NotificationBloc(context),
          child: NotificationView(),
        );
}
