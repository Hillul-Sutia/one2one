class UserDetails {
  final String? userId;
  final String? userName;
  UserDetails({this.userId, this.userName});
  factory UserDetails.fromRawJson(Map<String, dynamic> jsonData) {
    return UserDetails(
        userId: jsonData['userId'], userName: jsonData['userName']);
  }
  Map<String, dynamic> toJson(Map<String, dynamic> data) {
    return {'userId': userId, 'userName': userName};
  }
}
