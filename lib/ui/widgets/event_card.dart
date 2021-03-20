import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/util/assets.dart';

class EventCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;

  const EventCard({
    Key key,
    this.imgUrl = '',
    this.title,
    this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      height: 150,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: imgUrl == null || imgUrl.isEmpty
                ? AssetImage(Assets.EVENT_GRAPHIC)
                : NetworkImage(imgUrl),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            "$desc",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
