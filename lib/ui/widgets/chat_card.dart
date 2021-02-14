import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 2,
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            ProfileImage(
              firstName: "Saman",
              lastName: "ajefa",
              maxRadius: 20,
            ),
            Column(
              children: [
                Text("Name"),
                Text("Message"),
              ],
            ),
            Expanded(child: Container()),
            Text("10 min ago"),
          ],
        ),
      ),
    );
  }
}
