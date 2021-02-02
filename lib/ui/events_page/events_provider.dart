import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events_bloc.dart';
import 'events_view.dart';

class EventsProvider extends BlocProvider<EventsBloc> {
  EventsProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => EventsBloc(context),
          child: EventsView(),
        );
}
