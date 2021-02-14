import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'hall_booking_details_bloc.dart';
import 'hall_booking_details_view.dart';

class HallBookingDetailsProvider extends BlocProvider<HallBookingDetailsBloc> {
  HallBookingDetailsProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => HallBookingDetailsBloc(context),
          child: HallBookingDetailsView(),
        );
}
