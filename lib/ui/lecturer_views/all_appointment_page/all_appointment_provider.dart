import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_appointment_bloc.dart';
import 'all_appointment_view.dart';

class AllAppointmentProvider extends BlocProvider<AllAppointmentBloc> {
  AllAppointmentProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => AllAppointmentBloc(context),
          child: AllAppointmentView(),
        );
}
