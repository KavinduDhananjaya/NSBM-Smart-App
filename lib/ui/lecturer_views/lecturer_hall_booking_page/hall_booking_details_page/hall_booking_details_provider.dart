import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall_request.dart';

import 'hall_booking_details_bloc.dart';
import 'hall_booking_details_view.dart';

class HallBookingDetailsProvider extends BlocProvider<HallBookingDetailsBloc> {
  HallBookingDetailsProvider({
    Key key,
   @required HallRequest request,
  }) : super(
          key: key,
          create: (context) => HallBookingDetailsBloc(context),
          child: HallBookingDetailsView(request: request,),
        );
}
