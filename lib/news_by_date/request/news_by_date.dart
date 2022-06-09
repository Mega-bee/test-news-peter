class NewsByDateFilterRequest {


  NewsByDateFilterRequest();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['json'] ='true';
    data['fragment'] ='true';

    return data;
  }
}
