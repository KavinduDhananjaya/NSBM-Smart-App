import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'time_table_bloc.dart';
import 'time_table_view.dart';

class TimeTableProvider extends BlocProvider<TimeTableBloc> {
  TimeTableProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => TimeTableBloc(context),
          child: TimeTableView(),
        );
}
