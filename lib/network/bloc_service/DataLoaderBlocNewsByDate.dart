import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../news_by_date/model/newsByDate.dart';

enum RequestType { get, post, put }

class GlobalEventDate extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchData extends GlobalEventDate {
  final String? url;

  final String? header;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? query;
  final RequestType requestType;

  FetchData(this.url,
      {this.body, required this.requestType, this.query, this.header});
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

class NewsByDateBloc extends Bloc<GlobalEventDate, GlobalState> {
  NewsByDateBloc(initialState) : super(initialState);

  _getRequest(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    print("GET");
    Uri uri = Uri.parse(url);
    print("queryParameters:${queryParameters}");
    final finalUri = uri.replace(queryParameters: queryParameters); //USE THIS
    print('hihihihihihihihihihihihi');
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

  _setHeaders() {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Host': 'numbersapi.p.rapidapi.com',
      'X-RapidAPI-Key': '83ae47dc36msh5194c852ec1829cp100603jsn2f5d33e9aef3'
    };

    return headers;
  }

  @override
  Stream<GlobalState> mapEventToState(GlobalEventDate event) async* {
    // TODO: implement mapEventToState
    if (event is FetchData) {
      print("insdie fetch data");
      yield Loading();
      try {
        http.Response? response;

        print('Url: ${event.url}');
        if (event.requestType == RequestType.get) {
          print("hello christian");
          response = await _getRequest(event.url ?? '',
              headers: _setHeaders(), queryParameters: event.query);
          print("response:${response}");
        }
        if (response != null) {
          print('Response: ${response.statusCode}');
          print('Body: ${response.body}');
          NewsByDateModel? webServiceResponse;
          try {
            webServiceResponse =
                NewsByDateModel.fromJson(json.decode(response.body));
            print("webServiceResponse:${webServiceResponse}");
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
