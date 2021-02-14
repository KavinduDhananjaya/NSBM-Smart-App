import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecture_appointment_details_bloc.dart';
import 'lecture_appointment_details_view.dart';

class LectureAppointmentDetailsProvider extends BlocProvider<LectureAppointmentDetailsBloc> {
  LectureAppointmentDetailsProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LectureAppointmentDetailsBloc(context),
          child: LectureAppointmentDetailsView(),
        );
}
