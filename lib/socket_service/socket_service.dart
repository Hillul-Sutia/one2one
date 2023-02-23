import 'dart:async';
import 'package:one2one/model/chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static late StreamController<Chat> _socketResponse;
  static late StreamController<List<List<String>>> _userResponse;
  //final controller = StreamController<List<Map<String, dynamic>>>();
  //static late StreamController<List<dynamic>> _userDetails;
  static late io.Socket _socket;
  static String _userName = '';
  static String? get userId => _socket.id;

  static Stream<Chat> get getResponse =>
      _socketResponse.stream.asBroadcastStream();

  static Stream<List<List<String>>> get userResponse =>
      _userResponse.stream.asBroadcastStream();

  // static Stream<List<dynamic>> get userDetails =>
  //     _userDetails.stream.asBroadcastStream();

  static void setUserName(String name) {
    _userName = name;
  }

  static void sendMessage(String message) {
    _socket.emit(
        'message',
        Chat(
          userId: userId,
          userName: _userName,
          message: message,
          time: DateTime.now().toString(),
        ));
  }

  static void sendPrivateMessage(String message) {
    _socket.emit(
        'private message',
        Chat(
          userId: userId,
          userName: _userName,
          message: message,
          time: DateTime.now().toString(),
        ));
  }

  static void connectAndListen() {
    _socketResponse = StreamController<Chat>();
    _userResponse = StreamController<List<List<String>>>();

    _socket = io.io(
        //serverUrl,
        'http://10.10.11.151:8080',
        //10.10.8.94//192.168.97.85
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .setQuery({'userName': _userName})
            .build());

    _socket.connect();

    //When an event recieved from server, data is added to the stream
    _socket.on('message', (data) {
      //here data is the incoming data which is of jsn type data
      _socketResponse.sink.add(Chat.fromRawJson(data));
    });
    // _socket.on("private message", (data) {
    //   _socketResponse.sink.add(Chat.fromRawJson(data));
    // });
    //when users are connected or disconnected
    _socket.on('users', (data) {
      List<List<String>> userList = [];

      for (var user in data) {
        List<String> userData = [user['username'], user['socketId']];
        userList.add(userData);
      }

      //_socketInfoController.add(userList);
      //var users = (data as List<List<dynamic>>).map((e) => e.toString()).toList();
      _userResponse.sink.add(userList);
    });
    // _socket.on('userdetails', (data) {
    //   Map<String,dynamic> userdetails = json.decode(data);
    //   _userDetails.sink.add(userdetails);
    //   //json.decode(data);
    // });

    // _socket.onDisconnect((_) => print('disconnect'));
  }

  static void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
    _socketResponse.close();
    _userResponse.close();
  }
}
