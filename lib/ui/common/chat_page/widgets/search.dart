import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/chat_page/chat_detail_page/chat_detail_page.dart';
import 'package:smart_app/ui/common/chat_page/chat_page.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchEditingController = new TextEditingController();



  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(
                "Select contact",
                style: TextStyle(
                  color: StyledColors.DARK_GREEN,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
      ),
      body: Container(
        child: BlocBuilder<RootBloc, RootState>(
            buildWhen: (pre, current) =>
                pre.allLecturers != current.allLecturers,
            builder: (context, state) {
              if (state.allLecturers.isEmpty) {
                return Center(
                  child: Text("No Lecturers"),
                );
              }

              List<Widget> children = [];

              for (int i = 0; i < state.allLecturers.length; i++) {
                final lecturer = state.allLecturers[i];

                final tile = ListTile(
                  onTap: () {
                    if (chatBloc.state?.chatRooms != null &&
                        chatBloc.state.chatRooms.isNotEmpty) {
                      final chatRoom = chatBloc.state.chatRooms
                          .where(
                              (element) => element.users.contains(lecturer.ref))
                          .toList(growable: false);

                      if (chatRoom.isNotEmpty) {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetailProvider(
                              chatRoom: chatRoom[0],
                              user: lecturer.ref,
                            ),
                          ),
                        );
                        return;
                      }
                    }

                    chatBloc.add(CreateChatRoom(lecturer));
                    Navigator.pop(context);
                  },
                  title: Text(lecturer.name ?? ""),
                  subtitle: Text("Lecturer"),
                  leading: ProfileImage(
                    firstName: lecturer.name,
                    lastName: " ",
                    image: lecturer.profileImage == null ||
                            lecturer.profileImage.isEmpty
                        ? null
                        : NetworkImage(lecturer.profileImage),
                    radius: 25,
                    backgroundColor: StyledColors.PRIMARY_COLOR,
                  ),
                );
                children.add(tile);
              }

              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: StyledColors.PRIMARY_COLOR.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: TextField(
                      onChanged: (value) {
                      },
                      style: TextStyle(
                        fontSize: 15.0,
                        color: StyledColors.DARK_BLUE,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: StyledColors.DARK_BLUE,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey[300],
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "faf Name",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: StyledColors.DARK_BLUE,
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: children,
                  )),
                ],
              );
            }),
      ),
    );
  }
}