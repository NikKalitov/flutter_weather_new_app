import 'package:shared_preferences/shared_preferences.dart';

class BigWeatherModel{
  String? iconID;
  var weatherList;
  //String? cityName;
  double? currentTemp;
  double? currentWind;
  int? currentHumidity;
  double? feelsLike;
  double? currentPressure;
  //SharedPreferences? spref;

  BigWeatherModel({
    //this.cityName, 
    this.currentTemp, 
    this.currentWind, 
    this.currentHumidity, 
    this.feelsLike, 
    this.currentPressure,
    this.iconID,
    this.weatherList,
  });

  BigWeatherModel.fromJson(Map<String, dynamic> json){
    //cityName = spref!.getString('cityName');
    currentTemp = json['current']['temp'];
    currentWind = json['current']['wind_speed'];
    currentPressure = (json['current']['pressure'] / 1.33);
    currentHumidity = json['current']['humidity'];
    feelsLike = json['current']['feels_like'].toDouble();
    iconID = json['current']['weather'][0]['icon'];
    weatherList = json['daily'];
  }

  BigWeatherModel.errorConstructor(){
    currentTemp = 0.toDouble();
    currentWind = 0.toDouble();
    currentPressure = 0.toDouble();
    currentHumidity = 0;
    feelsLike = 0.toDouble();
    iconID = '';
    weatherList = [];
  }
}