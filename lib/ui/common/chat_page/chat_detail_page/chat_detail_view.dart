import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/chat_page/chat_detail_page/chat_detail_page.dart';
import 'package:smart_app/ui/common/chat_page/widgets/message_tile.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';

import 'chat_detail_bloc.dart';
import 'chat_detail_state.dart';

class ChatDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChatDetailViewState();
}

class ChatDetailViewState extends State<ChatDetailView> {
  static final log = Log("ChatDetailView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  TextEditingController messageEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final chat_detailBloc = BlocProvider.of<ChatDetailBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading ChatDetail View");

    addMessage() {
      if (messageEditingController.text.isNotEmpty) {
        chat_detailBloc.add(CreateMessage(messageEditingController.text));

        setState(() {
          messageEditingController.text = "";
        });
      }
    }

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                ProfileImage(
                  radius: 20,
                  firstName: "KA",
                  lastName: "Dhana",
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kriss Benwat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            BlocBuilder<ChatDetailBloc, ChatDetailState>(
                buildWhen: (pre, current) => pre.allChat != current.allChat,
                builder: (context, state) {
                  if (state.allChat == null) {
                    return loadingWidget;
                  }
                  return BlocBuilder<RootBloc, RootState>(
                      buildWhen: (pre, current) =>
                          pre.currentUser != current.currentUser,
                      builder: (context, snapshot) {
                        final user = snapshot.currentUser;

                        return Expanded(
                          child: ListView.builder(
                              itemCount: state.allChat.length,
                              itemBuilder: (context, index) {
                                return MessageTile(
                                  message: state.allChat[index].msg,
                                  sendByMe: user?.ref?.path ==
                                      state.allChat[index]?.sendBy?.path,
                                );
                              }),
                        );
                      });
                }),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 100,
              color: Colors.white,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                        hintText: "Message ...",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: 2,
                      onFieldSubmitted: (value) {
                        addMessage();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      addMessage();
                    },
                    icon: Icon(
                      Icons.send,
                      color: StyledColors.PRIMARY_COLOR,
                      size: 32,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ChatDetailBloc, ChatDetailState>(
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
