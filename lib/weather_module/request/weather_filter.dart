class WeatherFilterRequest {
  num? lat;
  num? lon;

  WeatherFilterRequest({this.lat, this.lon,});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat.toString();
    data['lon'] = this.lon.toString();
    data['appid'] = "21fe65287ea08f9a8fe2013027e7d9f2";

    return data;
  }
}
