import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/lecturer_views/lecturer_hall_booking_page/hall_booking_details_page/hall_booking_details_event.dart';

import 'hall_booking_details_bloc.dart';
import 'hall_booking_details_state.dart';

class HallBookingDetailsView extends StatelessWidget {
  static final log = Log("HallBookingDetailsView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final HallRequest request;

  CustomSnackBar customSnackBar;
  final titleStyle = TextStyle(
    color: StyledColors.DARK_BLUE,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final subtitleStyle = TextStyle(
    color: Colors.black.withOpacity(0.6),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  HallBookingDetailsView({Key key, @required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final hall_booking_detailsBloc =
        BlocProvider.of<HallBookingDetailsBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading HallBookingDetails View");

    customSnackBar = CustomSnackBar(scaffoldKey: scaffoldKey);

    final dueDate = DateFormat("dd/MM/yyyy").format(request.date.toDate());
    final dueTime = new DateFormat.jm().format(request.date.toDate());


    final scaffold = Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Hall Booking Details",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<HallBookingDetailsBloc, HallBookingDetailsState>(
          buildWhen: (pre, current) => true,
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "${request.type}",
                    style: titleStyle,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Text(
                        "Faculty",
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "${request.faculty}",
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Purpose",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      request.purpose,
                      style: subtitleStyle,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date and Time",
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "${dueDate}  ${dueTime}",
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "Capacity",
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "${request.capacity.toString()}",
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hall Number",
                        style: titleStyle,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "21",
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  request.state=="pending"?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () {
                          hall_booking_detailsBloc.add(RejectEvent(request));
                        },
                        child: Text("Reject"),
                        color: StyledColors.LIGHT_GREEN,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FlatButton(
                          onPressed: () {
                            hall_booking_detailsBloc.add(ConfirmEvent(request));
                          },
                          child: Text("Confirm"),
                          color: StyledColors.PRIMARY_COLOR),
                    ],
                  ):Container(),
                ],
              ),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<HallBookingDetailsBloc, HallBookingDetailsState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<HallBookingDetailsBloc, HallBookingDetailsState>(
          listenWhen: (pre, current) => pre.state != current.state,
          listener: (context, state) {
            if (state.state == 1) {
              customSnackBar?.showLoadingSnackBar(
                  backgroundColor: StyledColors.PRIMARY_COLOR);
            } else if (state.state == 2) {
              customSnackBar?.hideAll();
              Navigator.pop(context);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
