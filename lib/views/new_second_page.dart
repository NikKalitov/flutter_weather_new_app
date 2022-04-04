// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_weather_new_app/model/new_weather_model.dart';


class SecondScreen extends StatelessWidget {
  SecondScreen({ 
    Key? key,
    required this.model
  }) : super(key: key);

  final BigWeatherModel model;

  String timeConverter(int time){
    print(time);
    String string, weekday, day, month, year;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time*1000);
    weekday = weekdayConverter(dateTime.weekday);
    dateTime.day ~/ 10 == 0 ? day = '0${dateTime.day}': day = '${dateTime.day}';
    dateTime.month ~/ 10 == 0 ? month = '0${dateTime.month}': month = '${dateTime.month}';
    year = '${dateTime.year}';
    string = '$weekday $day.$month.$year';
    return string;
  }

  int pressureConverter(int a){
    int b = (a/1.33).floor();
    return b;
  }

  String weekdayConverter(int a){
    String b = '';
    switch(a){
      case 1:
      b = 'Пн';
        break;
      case 2:
      b = 'Вт';
        break;
      case 3:
      b = 'Ср';
        break;
      case 4:
      b = 'Чт';
        break;
      case 5:
      b = 'Пт';
        break;
      case 6:
      b = 'Сб';
        break;
      case 7:
      b = 'Вс';
        break;
    }
    return b;
  }

  final TextStyle leftColumn = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    fontStyle: FontStyle.italic
  );
  final TextStyle rightColumn = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Прогноз'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
      ),
      backgroundColor: Colors.grey.shade400,
      body: ListView.builder(
        itemCount: model.weatherList.length,
        itemBuilder: (context, index) {
          /*return Container(
            alignment: 
          );*/
          return Column(
            children: [ 
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeConverter(model.weatherList[index]['dt']),
                    style: TextStyle(
                      fontSize: 23.0,
                    ),
                  ),
                  Image.network(
                    'http://openweathermap.org/img/wn/${model.weatherList[index]['weather'][0]['icon']}@2x.png',
                    scale: 1.5,
                  ),
                  //Icon(Icons.ac_unit),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Температура', style: leftColumn,),
                      SizedBox(height: 5.0,),
                      Text('Ощущение', style: leftColumn),
                      SizedBox(height: 5.0,),
                      Text('Ветер', style: leftColumn),
                      SizedBox(height: 5.0,),
                      Text('Давление', style: leftColumn),
                      SizedBox(height: 5.0,),
                      Text('Влажность', style: leftColumn),
                      //SizedBox(height: 5.0,),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${model.weatherList[index]['temp']['day']}°C / ${model.weatherList[index]['temp']['night']}°C', style: rightColumn,),
                      SizedBox(height: 5.0,),
                      Text('${model.weatherList[index]['feels_like']['day']}°C / ${model.weatherList[index]['feels_like']['night']}°C', style: rightColumn,),
                      SizedBox(height: 5.0,),
                      Text('${model.weatherList[index]['wind_speed']} м/с', style: rightColumn,),
                      SizedBox(height: 5.0,),
                      Text('${pressureConverter(model.weatherList[index]['pressure']).toString()} мм.', style: rightColumn,),
                      SizedBox(height: 5.0,),
                      Text('${model.weatherList[index]['humidity']}%', style: rightColumn,),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              //Divider(thickness: 2.0, color: Colors.white,)
            ]
          );
        },
      ),
      // body: Column(
      //   children: [
      //     Text(model.weatherList.length.toString())
      //   ],
      // ),
    );
  }
}