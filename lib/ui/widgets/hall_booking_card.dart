import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

class HallBookingCard extends StatelessWidget {
  final int type;

  const HallBookingCard({
    Key key,
    this.type = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 4),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: type == 0
                ? Colors.green.withOpacity(0.4)
                : type == 1
                    ? Colors.red.withOpacity(0.4)
                    : Colors.blue.withOpacity(0.4),
          )),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 4,
          ),
          ProfileImage(
            firstName: "Kav",
            lastName: "adf",
            maxRadius: 20,
          ),
          SizedBox(
            width: 24,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Details of that booking",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: StyledColors.DARK_BLUE.withOpacity(0.5)),
              ),
            ],
          ),
          Spacer(),
          Text(
            "1 min ago",
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
    );
  }
}
