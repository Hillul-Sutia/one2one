import 'package:flutter/material.dart';
import 'package:one2one/screens/individual_chat_screen/chat_text_input.dart';
import 'package:one2one/screens/individual_chat_screen/message_view.dart';
import 'package:one2one/socket_service/socket_service.dart';
import 'package:one2one/model/chat.dart';

class IndividualChatScreen extends StatelessWidget {
  const IndividualChatScreen({Key? key, required this.userSocketId})
      : super(key: key);
  final String userSocketId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //Center(child: Text(userSocketId))
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ChatBody(),
            SizedBox(
              height: 6,
            ),
            ChatTextInput(),
          ],
        ),
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatMessages = <Chat>[];
    //var chatMessages = <PrivateChat>[];
    ScrollController scrollController = ScrollController();
    void scrollDown() {
      try {
        Future.delayed(
            const Duration(milliseconds: 300),
            () => scrollController
                .jumpTo(scrollController.position.maxScrollExtent));
      } on Exception catch (_) {}
    }

    return Expanded(
        child: StreamBuilder(
      stream: SocketService.getResponse,
      builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data != null) {
          chatMessages.add(snapshot.data!);
        }
        scrollDown();
        return ListView.builder(
            controller: scrollController,
            itemCount: chatMessages.length,
            itemBuilder: (BuildContext context, int index) =>
                MessageView(chat: chatMessages[index]));
      },
    ));
  }
}
