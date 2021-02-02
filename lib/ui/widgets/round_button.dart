import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

class RoundButton extends SizedBox {
  RoundButton({
    bool filled = true,
    double height = 48.0,
    double width,
    Color color1 = StyledColors.PRIMARY_COLOR,
    Color color2 = Colors.white,
    Color borderColor,
    @required VoidCallback onClicked,
    @required String text,
  }) : super(
          height: height,
          child: MaterialButton(
            color: filled ? color1 : color2,
            elevation: 0,
            onPressed: onClicked,
            minWidth: width ?? double.infinity,
            shape: onClicked == null ? null : RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? (filled ? color1 : color2),
              ),
              borderRadius: BorderRadius.circular(height / 6),
            ),
            disabledColor: StyledColors.PRIMARY_COLOR,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1.25,
                color: filled ? color2 : color1,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
}
