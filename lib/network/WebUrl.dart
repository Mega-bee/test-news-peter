class Urls {
  /*--------BASES-------------------*/
  static const String DOMAIN = 'https://newsapi.org/v2/everything';
  static const String WEATHER_DOMAIN = 'https://api.openweathermap.org/data/2.5/weather';
  static const String NEWS_BY_DATE_DOMAIN = 'https://numbersapi.p.rapidapi.com/';
  static const String NEWS_BY_DATE_DOMAIN_Date = '6/2/date';
  static const String BASE_API = DOMAIN + '';

  static const String BASE_API_ACCOUNT = DOMAIN + '/api/';
  static const String BASE_API_PATIENTS = DOMAIN + '/api/';
  static const String BASE_API_NOTIFICATIONS = DOMAIN + '/api/';

  /*--------Auth-------------------*/
  static const LOGIN = BASE_API_ACCOUNT + '/';
  static const FORGET_PASS = BASE_API_ACCOUNT + '/';

  /*--------home-------------------*/
  static const String NEWS_ONE = DOMAIN;
  static const String WEATHER = WEATHER_DOMAIN;
  static const String NEWS_DATE = NEWS_BY_DATE_DOMAIN+NEWS_BY_DATE_DOMAIN_Date;

  /*--------TOKEN-------------------*/
  static const apiToken = 'a1a15821dc0e4d7cb89bd20d3f1e2202';
}
