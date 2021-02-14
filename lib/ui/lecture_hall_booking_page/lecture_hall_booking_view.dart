import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/hall_booking_page/hall_info_view.dart';
import 'package:smart_app/ui/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/hall_booking_card.dart';

import 'lecture_hall_booking_bloc.dart';
import 'lecture_hall_booking_state.dart';

class LectureHallBookingView extends StatelessWidget {
  static final log = Log("LectureHallBookingView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_hall_bookingBloc =
        BlocProvider.of<LectureHallBookingBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureHallBooking View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HallInfoView(),
                    fullscreenDialog: true),
              );
            },
          ),
        ],
        title: Text(
          "Hall Booking",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<LectureHallBookingBloc, LectureHallBookingState>(
          buildWhen: (pre, current) => true,
          builder: (context, state) {
            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: StyledColors.PRIMARY_COLOR)
                          ),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("All"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: StyledColors.PRIMARY_COLOR)
                          ),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Confirmed"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: StyledColors.PRIMARY_COLOR)
                          ),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Pending"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: StyledColors.PRIMARY_COLOR)
                          ),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Reject"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32,),
                  HallBookingCard(type: 0,),
                  HallBookingCard(type: 1,),
                  HallBookingCard(type: 1,),
                  HallBookingCard(type: 3,)
                ],
              ),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LectureHallBookingBloc, LectureHallBookingState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
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
