import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appointment_details_bloc.dart';
import 'appointment_details_view.dart';

class AppointmentDetailsProvider extends BlocProvider<AppointmentDetailsBloc> {
  AppointmentDetailsProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => AppointmentDetailsBloc(context),
          child: AppointmentDetailsView(),
        );
}
