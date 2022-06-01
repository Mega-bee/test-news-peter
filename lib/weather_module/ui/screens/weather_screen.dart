import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/helpers/colors.dart';

import '../../../Views/connactionError.dart';
import '../../../network/WebUrl.dart';
import '../../../network/bloc_service/DataLoaderBlocWeather.dart';
import '../../model/weatherModel.dart';

import '../../request/weather_filter.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc weatherBloc;

  late num lat = 0.0;
  late num lon = 0.0;

  @override
  void initState() {
    initCurrentLocation();
    weatherBloc = WeatherBloc(Default());
    weatherBloc.add(
      FetchData(
        Urls.WEATHER_DOMAIN,
        requestType: RequestType.get,
        query: WeatherFilterRequest(
          lat: lat,
          lon: lon,
        ).toJson(),
      ),
    );
  }

  initCurrentLocation()async{
    await getCurrentLocation();
  }

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if( permission== LocationPermission.denied){
      //nothing
    }
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      lon = position.longitude;

      print("lat: ${lat}");
      print("lon: ${lon}");
    });
  }


  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 9,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Icon(Icons.cloud),
            )
          ],
          title: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text("Weather Forecast"),
          ),
          // centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await weatherBloc
              ..add(
                FetchData(
                  Urls.WEATHER_DOMAIN,
                  requestType: RequestType.get,
                  query: WeatherFilterRequest(
                    lat: 33.8446841,
                    lon: 35.8555651,
                  ).toJson(),
                ),
              );
          },
          child: BlocBuilder<WeatherBloc, GlobalState>(
              bloc: weatherBloc,
              builder: (context, state) {
                if (state is Loading) {
                  print("Loading");
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (state is ConnectionError) {
                  print("Connection error");
                  return ConnectionErrorScreen(
                      errorMessage: 'connectionError',
                      retry: () {
                        BlocProvider.of<WeatherBloc>(context)
                          ..add(FetchData(Urls.NEWS_ONE,
                              requestType: RequestType.get));
                      });
                } else if (state is Error) {
                  print("Error try again please");
                  return ConnectionErrorScreen(
                      errorMessage: state.errorMessage,
                      retry: () {
                        BlocProvider.of<WeatherBloc>(context)
                          ..add(FetchData(Urls.WEATHER_DOMAIN,
                              requestType: RequestType.get));
                      });
                } else if (state is Successfully) {
                  weatherModel ServiceWeather = state.data as weatherModel;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Country: ${ServiceWeather.name ?? "no name"}",
                              style: TextStyle(color: textColor, fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${DateFormat.yMd().add_jm().format(
                                    DateTime.parse(
                                      now.toString(),
                                    ),
                                  )}",
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Main",
                                style:
                                    TextStyle(color: textColor, fontSize: 30),
                              ),

                              Image.network(
                                  "http://openweathermap.org/img/w/${ServiceWeather.weather![0].icon}.png")
                              // Lottie.asset(
                              //   "assets/images/weather.json",
                              //   height: 100,
                              //   width: 100,
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "temp: ${(ServiceWeather.main!.temp! - 273.15).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Text(
                                "feels_like: ${(ServiceWeather.main!.feelsLike! - 273.15).toStringAsFixed(1)}",
                                style:
                                    TextStyle(color: textColor, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "temp_max: ${(ServiceWeather.main!.tempMax! - 273.15).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "temp_min: ${(ServiceWeather.main!.tempMin! - 273.15).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "pressure: ${(ServiceWeather.main!.pressure! - 273.15).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Text(
                                "humidity: ${(ServiceWeather.main!.humidity! - 273.15).toStringAsFixed(1)}",
                                style:
                                    TextStyle(color: textColor, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "sea_level: ${(ServiceWeather.main!.seaLevel! - 273).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "grnd_level: ${(ServiceWeather.main!.grndLevel! - 273.15).toStringAsFixed(1)}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(color: textColor, fontSize: 30),
                            ),
                            Lottie.asset(
                              "assets/images/lottiewind.json",
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "speed: ${ServiceWeather.wind!.speed ?? "no speed"}",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "deg: ${ServiceWeather.wind!.deg ?? "no deg"}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            Text(
                              "gust: ${ServiceWeather.wind!.gust ?? "no gust"}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Clouds",
                                style:
                                    TextStyle(color: textColor, fontSize: 30),
                              ),
                              Lottie.asset(
                                "assets/images/cloudlottie.json",
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "All: ${ServiceWeather.clouds!.all ?? "no clouds"}",
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          // thickness of the line
                          indent: 20,
                          // empty space to the leading edge of divider.
                          endIndent: 20,
                          // empty space to the trailing edge of the divider.
                          color: textColor,
                          // The color to use when painting the line.
                          height: 20,
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
        ));
  }
}
