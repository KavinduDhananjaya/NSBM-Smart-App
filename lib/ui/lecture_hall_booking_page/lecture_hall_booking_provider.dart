import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecture_hall_booking_bloc.dart';
import 'lecture_hall_booking_view.dart';

class LectureHallBookingProvider extends BlocProvider<LectureHallBookingBloc> {
  LectureHallBookingProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LectureHallBookingBloc(context),
          child: LectureHallBookingView(),
        );
}
