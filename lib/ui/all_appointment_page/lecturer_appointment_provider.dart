import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecturer_appointment_bloc.dart';
import 'lecturer_appointment_view.dart';

class LecturerAppointmentProvider extends BlocProvider<LecturerAppointmentBloc> {
  LecturerAppointmentProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LecturerAppointmentBloc(context),
          child: LecturerAppointmentView(),
        );
}
