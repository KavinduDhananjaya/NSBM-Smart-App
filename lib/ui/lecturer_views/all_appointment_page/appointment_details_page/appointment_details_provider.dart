import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/lecturer_request.dart';

import 'appointment_details_bloc.dart';
import 'appointment_details_view.dart';

class AppointmentDetailsProvider extends BlocProvider<AppointmentDetailsBloc> {
  AppointmentDetailsProvider({
    Key key,
    @required LectureRequest request,
  }) : super(
          key: key,
          create: (context) => AppointmentDetailsBloc(context),
          child: AppointmentDetailsView(request: request,),
        );
}
