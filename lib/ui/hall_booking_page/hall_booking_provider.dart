import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'hall_booking_bloc.dart';
import 'hall_booking_view.dart';

class HallBookingProvider extends BlocProvider<HallBookingBloc> {
  HallBookingProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => HallBookingBloc(context),
          child: HallBookingView(),
        );
}
