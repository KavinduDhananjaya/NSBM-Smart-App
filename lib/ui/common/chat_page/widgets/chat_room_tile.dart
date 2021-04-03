import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/chat_room.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/user_repository.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/chat_page/chat_detail_page/chat_detail_page.dart';

class ChatRoomsTile extends StatelessWidget {
  final DocumentReference user;
  final ChatRoom chatRoom;
  final String lastMsg;

  ChatRoomsTile({
    @required this.user,
    @required this.chatRoom,
    @required this.lastMsg,
  });

  final separator = Container(
    margin: EdgeInsets.symmetric(horizontal: 0),
    height: 1.2,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          StyledColors.DARK_GREEN.withOpacity(0.1),
          StyledColors.PRIMARY_COLOR.withOpacity(0.3)
        ],
      ),
    ),
  );

  final addon = RepositoryAddon(repository: new UserRepository());

  Future<User> getUser(DocumentReference ref) async {
    final user = await addon.fetch(ref: ref);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailProvider(
              user: user,
              chatRoom: chatRoom,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: StyledColors.LIGHT_GREEN.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  FutureBuilder(
                    future: getUser(user),
                    builder: (context, snapshot) {
                      return ProfileImage(
                        firstName: snapshot.hasData ? snapshot.data.name : "-",
                        lastName: " ",
                        radius: 25,
                        image: snapshot.hasData
                            ? snapshot.data.profileImage == null ||
                            snapshot.data.profileImage.isEmpty
                            ? null
                            : NetworkImage(snapshot.data.profileImage)
                            : null,
                        backgroundColor: StyledColors.PRIMARY_COLOR,
                      );
                    }, // The widget using the data
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder(
                            future: getUser(user),
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.hasData ? snapshot.data.name : "-",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              );
                            }, // The widget using the data
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            lastMsg ?? "",
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
