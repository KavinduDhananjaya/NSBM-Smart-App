import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecture_appointment_bloc.dart';
import 'lecture_appointment_view.dart';

class LectureAppointmentProvider extends BlocProvider<LectureAppointmentBloc> {
  LectureAppointmentProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LectureAppointmentBloc(context),
          child: LectureAppointmentView(),
        );
}
