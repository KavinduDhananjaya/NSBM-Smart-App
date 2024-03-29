import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'file:///E:/My/External%20Projects/NSBM-SmartApp/NSBM-Smart-App/lib/ui/common/chat_page/widgets/search.dart';
import 'package:smart_app/ui/common/chat_page/widgets/chat_room_tile.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'chat_bloc.dart';
import 'chat_state.dart';

class ChatView extends StatelessWidget {


  static final log = Log("ChatView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

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

            return Stack(
              children: [

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    color: Colors.lightGreen.withOpacity(0.2),

                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.chatRooms.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {

                            final user=rootBloc.state.currentUser.ref;

                            final chatUsers=List.of(state.chatRooms[index].users);
                            chatUsers.remove(user);

                            return ChatRoomsTile(
                              user: chatUsers.first,
                              chatRoom: state.chatRooms[index],
                              lastMsg: state.chatRooms[index].lastMsg ?? "",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat_outlined),
        backgroundColor: StyledColors.PRIMARY_COLOR,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: chatBloc,
                child: Search(),
              ),
            ),
          );
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
