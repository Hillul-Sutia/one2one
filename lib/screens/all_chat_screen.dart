import 'package:flutter/material.dart';
import 'package:one2one/socket_service/socket_service.dart';
import 'individual_chat_screen/individual_chat_screen.dart';

class AllChatScreen extends StatefulWidget {
  const AllChatScreen({super.key, required this.username});
  final String username;
  @override
  State<AllChatScreen> createState() => _AllChatScreenState();
}

class _AllChatScreenState extends State<AllChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Chats"),
      ),
      body: StreamBuilder<List<List<String>>>(
        stream: SocketService.userResponse,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: LinearProgressIndicator());
          }

          if (snapshot.data == null) {
            return const SizedBox();
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (snapshot.data ?? [])
                  //.where((e) => e[0] != widget.username)
                  .map((e) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: ListTile(
                          // avatar: const Icon(Icons.person),
                          // elevation: 2,
                          // label: Text(e)
                          leading: const Icon(Icons.person),
                          title: Text(e[0]),
                          trailing: Text(e[1]),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualChatScreen(
                                      userSocketId: SocketService.userId!),
                                ));
                          },
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("All Chats"),
    //   ),
    //   body: StreamBuilder(
    //     stream: SocketService.userResponse,
    //     builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.none) {
    //         return const Center(child: LinearProgressIndicator());
    //       }

    //       if (snapshot.data == null) {
    //         return const SizedBox();
    //       }

    //       return SingleChildScrollView(
    //         scrollDirection: Axis.vertical,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: (snapshot.data ?? [])
    //               //.where((e) => e[0] != widget.username)
    //               .map((e) => Container(
    //                     margin: const EdgeInsets.only(right: 6),
    //                     child: ListTile(
    //                       // avatar: const Icon(Icons.person),
    //                       // elevation: 2,
    //                       // label: Text(e)
    //                       leading: const Icon(Icons.person),
    //                       title: Text(e),
    //                       //trailing: Text(e[1]),
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                               builder: (context) => IndividualChatScreen(
    //                                   userSocketId: SocketService.userId!),
    //                             ));
    //                       },
    //                     ),
    //                   ))
    //               .toList(),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
