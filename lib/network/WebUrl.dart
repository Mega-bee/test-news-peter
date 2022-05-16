

class Urls {
  /*--------BASES-------------------*/
  static const String DOMAIN = 'https://newsapi.org/v2/everything';
  static const String QUERY = '?q=tesla&from=2022-05-11&to=2022-05-11&sortBy=popularity&apiKey=7f01a1f8c35e43d89dd699dcf501cfea';
  static const String BASE_API = DOMAIN + '';

  static const String BASE_API_ACCOUNT = DOMAIN + '/api/';
  static const String BASE_API_PATIENTS = DOMAIN + '/api/';
  static const String BASE_API_NOTIFICATIONS=DOMAIN+'/api/';
  /*--------Auth-------------------*/
  static const LOGIN = BASE_API_ACCOUNT + '/';
  static const FORGET_PASS = BASE_API_ACCOUNT + '/';


  /*--------home-------------------*/
  static const String NEWS_ONE = DOMAIN + QUERY;


  /*--------TOKEN-------------------*/
  static const apiKey = '7f01a1f8c35e43d89dd699dcf501cfea';

}
