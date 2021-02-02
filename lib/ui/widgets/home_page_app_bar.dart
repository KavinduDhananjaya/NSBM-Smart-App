import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

class HomePageAppBar extends StatelessWidget {
  final String title;

  const HomePageAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
            color: StyledColors.PRIMARY_COLOR.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(0))),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 12,),
              ProfileImage(
                firstName: "Kavindu",
                lastName: "Dhananjaya",
                backgroundColor: StyledColors.DARK_GREEN,
                minRadius: 25
              ),
              SizedBox(width: 16,),
              Text(
                "Hello, Kavindu",
                style: TextStyle(fontSize: 20, color: StyledColors.DARK_GREEN,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
