import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
          gradient: LinearGradient(
            colors: sendByMe
                ? [
                    StyledColors.PRIMARY_COLOR.withOpacity(0.8),
                    StyledColors.PRIMARY_COLOR.withOpacity(0.5)
                  ]
                : [Color(4290502395), Color(4284790262)],
          ),
        ),
        child: Text(
          message,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
