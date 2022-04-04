import 'dart:convert';

import 'package:flutter_weather_new_app/model/new_location_model.dart';
import 'package:flutter_weather_new_app/model/new_weather_model.dart';
import 'package:http/http.dart' as http;

class NewWeatherApiClient{
  /*Future<Weather>? getCurrentWeather(String location) async {
    var response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$location&limit=5&appid=b4e733eb5cecdff62ac9d5ee88c8830f&units=metric'));
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body));
    return Weather.fromJson(body);
  }*/

  Future<BigWeatherModel>? getWholeWeather(double lat, double lon) async {
    var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=alerts,hourly,minutely&appid=b4e733eb5cecdff62ac9d5ee88c8830f&units=metric'));
    var body = jsonDecode(response.body);
    //print('status code: ${response.statusCode}');
    if(response.statusCode == 200){
      return BigWeatherModel.fromJson(body);
    } else {
      return BigWeatherModel.errorConstructor();
    }
  }
  //http://api.openweathermap.org/geo/1.0/direct?q=Ульяновск&limit=1&appid=60dacc2590f38d9b2eac630a37d74e5e

  Future<Location>? getLocationFromString(String location) async {
    print('entered location function');
    var response = await http.get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$location&limit=1&appid=b4e733eb5cecdff62ac9d5ee88c8830f'));
    var body = jsonDecode(response.body);
    //print(Location.fromJson(body));
    //return Location.fromJson(body);
    return Location().newFunction(body);
  }  
}