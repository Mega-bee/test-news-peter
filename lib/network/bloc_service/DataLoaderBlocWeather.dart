import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/hive/hive.dart';

import '../../Model/WebServiceResponse.dart';
import '../../model/WebServiceResponse.dart';
import '../../model/WebServiceResponseWeather.dart';
import '../../weather_module/model/weatherModel.dart';
import '../WebUrl.dart';

enum RequestType { get, post, put }

class GlobalEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchData extends GlobalEvent {
  final String? url;

//  final String? token;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? query;
  final RequestType requestType;

  FetchData(this.url, {this.body, required this.requestType, this.query});
}

class GlobalState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Successfully extends GlobalState {
  final data;

  Successfully(this.data);
}

class ConnectionError extends GlobalState {}

class Error extends GlobalState {
  final errorCode;
  final errorMessage;

  Error(
    this.errorCode,
    this.errorMessage,
  );
}

class Loading extends GlobalState {}

class Default extends GlobalState {}

class WeatherBloc extends Bloc<GlobalEvent, GlobalState> {
  WeatherBloc(initialState) : super(initialState);

  _getRequest(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS
    // print('hihihihihihihihihihihihi');
    print(finalUri);
    final response = await http
        .get(finalUri, headers: headers)
        .timeout(const Duration(seconds: 120), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
//       return null;
    }).catchError((error, stackTrace) {
      print('INeRROR');
      print(error.toString());
    });
    return response;
  }

  _postRequest(String urll, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    var url = Uri.parse(urll);
    print(url);
    final response = http
        .post(url, headers: headers, body: body)
        .timeout(const Duration(seconds: 120), onTimeout: () {
      print('on Time');
//      return null;
      throw TimeoutException('The connection has timed out, Please try again!');
    }).catchError((error, stackTrace) {
      print('INeRROR');
      print(error.toString());
    });
    return response;
  }

  _putRequest(String url, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    print(body.length);
    print('----------------------------------------------------');
    final response = await http
        .put(Uri.parse(url), headers: headers, body: body)
        .timeout(const Duration(seconds: 120), onTimeout: () {
      throw TimeoutException('The connection has timed out, Please try again!');
//       return null;
    }).catchError((error, stackTrace) {
      print('INeRROR');
      print(error.toString());
    });
    return response;
  }

  _setHeaders() {
    var token = AuthPrefsHelper().getToken() ?? '';
    print("token: ${token}");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchData) {
      yield Loading();
      try {
        http.Response? response;

        print('Url: ${event.url}');
        if (event.requestType == RequestType.get) {
          // print("hello christian");
          response = await _getRequest(event.url ?? '',
              headers: _setHeaders(), queryParameters: event.query);
        }
        if (event.requestType == RequestType.put) {
          print("put");
          print("BODY: " + event.body.toString());
          response = await _putRequest(event.url ?? '', event.body ?? {},
              headers: _setHeaders());
        } else if (event.requestType == RequestType.post) {
          print("post");
          print(" URL : " + event.url!);
          print("BODY: " + event.body.toString());
          response = await _postRequest(event.url!, event.body ?? {},
              headers: _setHeaders());
        }
        if (response != null) {
          print('Response: ${response.statusCode}');
          print('Body: ${response.body}');
          weatherModel? webServiceResponse;
          try {
            webServiceResponse =
                weatherModel.fromJson(json.decode(response.body));
          } catch (exception) {
            print("exception: ${exception}");
            // listener.onJsonDataLoadingFailure(1);
            yield ConnectionError();
          }
          if (webServiceResponse != null) {
            yield Successfully(webServiceResponse);
          }
        } else {
          print("connection errorrrrr");
          yield ConnectionError();
        }
        // return response;

      } catch (exception) {
        //TODO: Add Translation.
        // throw Exception('No Connection');
        print('hihih');
        print(exception);
        yield ConnectionError();
      }
    }
  }
}
