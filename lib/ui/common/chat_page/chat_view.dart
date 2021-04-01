import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/chat_page/new/search.dart';
import 'package:smart_app/ui/common/chat_page/widgets/chat_room_tile.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'file:///E:/My/External%20Projects/NSBM-SmartApp/NSBM-Smart-App/lib/ui/common/chat_page/widgets/chat_card.dart';
import 'chat_bloc.dart';
import 'chat_state.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;

  ChatUsers(
      {@required this.name,
      @required this.messageText,
      @required this.imageURL,
      @required this.time});
}

class ChatView extends StatelessWidget {
  static final log = Log("ChatView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL:
            "https://firebasestorage.googleapis.com/v0/b/nsbm-smart-app.appspot.com/o/events%2Funnamed.jpg?alt=media&token=5dd54155-769a-45ed-b51d-73dfc369dd9e",
        time: "Now"),
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL:
            "https://firebasestorage.googleapis.com/v0/b/nsbm-smart-app.appspot.com/o/events%2Funnamed.jpg?alt=media&token=5dd54155-769a-45ed-b51d-73dfc369dd9e",
        time: "Now"),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Chat View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (pre, current) => pre.chatRooms != current.chatRooms,
          builder: (context, state) {
            if (state.chatRooms == null) {
              return loadingWidget;
            }

            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: state.chatRooms.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ChatRoomsTile(
                          userName: "UserName",
                          chatRoom: state.chatRooms[index],
                        );
                      })
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat_outlined),
        backgroundColor: StyledColors.PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ChatBloc, ChatState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
