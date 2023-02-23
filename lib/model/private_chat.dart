class PrivateChat {
  final String? userId;
  final String? userName;

  final String? toId;
  final String? message;
  final String? time;

  PrivateChat({this.userId, this.userName, this.toId, this.message, this.time});

  factory PrivateChat.fromRawJson(Map<String, dynamic> jsonData) {
    return PrivateChat(
        userId: jsonData['userId'],
        userName: jsonData['userName'],
        toId: jsonData['toId'],
        message: jsonData['message'],
        time: jsonData['time']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "UserName": userName,
      "senderId": toId,
      "message": message,
      "time": time
    };
  }
}
