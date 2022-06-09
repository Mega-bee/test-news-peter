class InstagramRequest {
  String? username;

  InstagramRequest({this.username});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = this.username;
    return data;
  }
}
