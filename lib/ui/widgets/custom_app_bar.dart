import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Container(
        decoration: BoxDecoration(
            color: StyledColors.PRIMARY_COLOR.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2))),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600, color: StyledColors.DARK_GREEN),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
