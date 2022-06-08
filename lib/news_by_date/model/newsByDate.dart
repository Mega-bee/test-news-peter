class NewsByDateModel {
  String? text;
  int? year;
  int? number;
  bool? found;
  String? type;

  NewsByDateModel({this.text, this.year, this.number, this.found, this.type});

  NewsByDateModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    year = json['year'];
    number = json['number'];
    found = json['found'];
    type = json['type'];
  }
}
