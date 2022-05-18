import 'package:news_app/news_module/model/NewsOne.dart';

class WebServiceResponse {
  String? status;
  String? errorMessage;
  List<NewsOne>? data;
  WebServiceResponse({this.status, this.errorMessage, this.data});
   WebServiceResponse.fromJson(Map<String, dynamic> item) {
   status =  item['status'];
    errorMessage =  item['message'];
    data = [];
      if(item['articles'] != null) {
        item['articles'].forEach((element) {
       data?.add(NewsOne.fromJson(element));
     }) ;
      }
  }}

