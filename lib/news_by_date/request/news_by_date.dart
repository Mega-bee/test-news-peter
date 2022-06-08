class NewsByDateFilterRequest {
  bool? json = true;
  bool? fragment = true;

  NewsByDateFilterRequest({this.json,this.fragment});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['json'] = this.json;
    data['fragment'] = this.fragment;

    return data;
  }
}
