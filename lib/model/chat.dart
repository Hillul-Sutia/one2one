class Chat {
  final String? userId;
  final String? userName;

  final String? senderId;
  final String? message;
  final String? time;

  Chat({this.userId, this.userName, this.senderId, this.message, this.time});

  factory Chat.fromRawJson(Map<String, dynamic> jsonData) {
    return Chat(
        userId: jsonData['userId'],
        userName: jsonData['userName'],
        senderId: jsonData['senderId'],
        message: jsonData['message'],
        time: jsonData['time']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "UserName": userName,
      "senderId": senderId,
      "message": message,
      "time": time
    };
  }
}
