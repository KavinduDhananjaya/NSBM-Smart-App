import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecturer_hall_booking_bloc.dart';
import 'lecturer_hall_booking_view.dart';

class LecturerHallBookingProvider extends BlocProvider<LecturerHallBookingBloc> {
  LecturerHallBookingProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LecturerHallBookingBloc(context),
          child: LectureHallBookingView(),
        );
}
