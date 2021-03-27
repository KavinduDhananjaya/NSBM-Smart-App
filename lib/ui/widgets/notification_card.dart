import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/util/routes.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final Timestamp createdAt;

  const NotificationCard({
    Key key,
    this.title,
    this.createdAt,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "$title",
                style: TextStyle(fontSize: 17),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                Routes.timeAgoSinceDate(createdAt.toDate()),
                style: TextStyle(
                    fontSize: 12, color: Colors.black87.withOpacity(0.4)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
