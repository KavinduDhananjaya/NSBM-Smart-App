import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/hall_repository.dart';
import 'package:smart_app/db/repository/user_repository.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/lecturer_views/all_appointment_page/appointment_details_page/appointment_details_page.dart';
import 'package:smart_app/ui/lecturer_views/lecturer_hall_booking_page/hall_booking_details_page/hall_booking_details_page.dart';
import 'package:smart_app/util/routes.dart';

class CommonBookingCard extends StatelessWidget {
  final bool isHallReq;
  final int type;
  final DocumentReference addedUser;
  final Timestamp addedTime;
  final Timestamp requestedDate;
  final String purpose;
  final DocumentReference hall;
  final GestureTapCallback onTap;

  CommonBookingCard({
    Key key,
    this.type = 0,
    this.addedUser,
    this.addedTime,
    this.purpose = '',
    this.hall,
    this.onTap,
    this.isHallReq=true,
    this.requestedDate,
  }) : super(key: key);

  final addon = RepositoryAddon(repository: new UserRepository());

  Future<User> getUser(DocumentReference ref) async {
    final user = await addon.fetch(ref: ref);
    return user;
  }

  final hallAddon = RepositoryAddon(repository: new HallRepository());

  Future<int> getHall(DocumentReference ref) async {
    final hall = await hallAddon.fetch(ref: ref);
    return hall.hallNumber;
  }

  @override
  Widget build(BuildContext context) {


    String date='-';
    String time='-';

    if(!isHallReq&&requestedDate!=null){
       date = new DateFormat("yyyy-MM-dd").format(requestedDate.toDate());
       time = new DateFormat.jm().format(requestedDate.toDate());
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: type == 0
                ? Colors.green.withOpacity(0.7)
                : type == 1
                    ? Colors.red.withOpacity(0.4)
                    : Colors.blue.withOpacity(0.6),
          ),
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 4,
            ),
            FutureBuilder(
              future: getUser(addedUser),
              builder: (context, snapshot) {
                return ProfileImage(
                  firstName: snapshot.hasData ? snapshot.data.name : "-",
                  lastName: " ",
                  maxRadius: 20,
                );
              }, // The widget using the data
            ),
            SizedBox(
              width: 24,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: getUser(addedUser),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData ? snapshot.data.name : "-",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    );
                  },
                ),
                SizedBox(
                  height: 3,
                ),
                FutureBuilder(
                    future: getHall(hall),
                    builder: (context, snapshot) {
                      final hall = snapshot.hasData ? snapshot.data : "-";
                      return Expanded(
                        flex: 1,
                        child: Container(
                          width: 220,
                          child: isHallReq?Text(
                            "Requested ${hall.toString()} hall for ${purpose}  ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: StyledColors.DARK_BLUE.withOpacity(0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ):Text(
                            "Requested a Appointment at ${date} ${time}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: StyledColors.DARK_BLUE.withOpacity(0.5),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
              ],
            ),
            Spacer(),
            Text(
              Routes.timeAgoSinceDate(addedTime.toDate()),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: StyledColors.DARK_BLUE.withOpacity(0.3)),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }
}
