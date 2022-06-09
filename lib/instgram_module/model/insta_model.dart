class InstaModel {
  int? userId;
  String? username;
  String? status;
  int? statusCode;

  InstaModel({this.userId, this.username, this.status, this.statusCode});

  InstaModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

}
