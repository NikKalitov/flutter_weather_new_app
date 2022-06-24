// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_weather_new_app/field_page.dart';
import 'package:flutter_weather_new_app/latloncity.dart';
import 'package:flutter_weather_new_app/model/new_location_model.dart';
import 'package:flutter_weather_new_app/model/new_weather_model.dart';
import 'package:flutter_weather_new_app/services/new_api_client.dart';
import 'package:flutter_weather_new_app/views/new_additional_information.dart';
import 'package:flutter_weather_new_app/views/new_city_selection.dart';
import 'package:flutter_weather_new_app/views/new_current_weather.dart';
import 'package:flutter_weather_new_app/views/new_second_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String value = 'Before';
  TextEditingController controller = TextEditingController();
  bool sprefGot = false;
  bool dataSprefGot = false;
  LatLonCity? latLonCity = LatLonCity();
  Location? location = Location();
  BigWeatherModel? model = BigWeatherModel();
  // bool hasConnection = false;
  bool hasConnection = true;
  bool sprefExists = false;
  bool sprefEmpty = true;
  late SharedPreferences sPref;
  late double? lat;
  late double? lon;
  late String? city;
  late String? country;

  Future<void> checkConnection() async {
    bool connectionBool = false;
    connectionBool = await InternetConnectionChecker().hasConnection;
    print('connectionBool $connectionBool');
    setState(() {
      hasConnection = connectionBool;
    });
    print('hasConnection $hasConnection');
  }

  Future<void> initSpref() async {
    sPref = await SharedPreferences.getInstance();
    setState(() {
      sprefGot = true;
    });
    await sprefEmptyCheck();
  }

  Future<void> sprefEmptyCheck() async {
    double? a = await sPref.getDouble('lat');
    if(a == null){
      setState(() {
        sprefEmpty = true;
      });
    }
    else{
      setState(() {
        sprefEmpty = false;
      });
    }
  }

  Future<void> fillSpref() async {
    setState(() {
      sPref.setDouble('lat', lat!);
      sPref.setDouble('lon', lon!);
      sPref.setString('cityName', city!);
      sPref.setString('countryName', country!);
    });
    sPref.setDouble('lat', lat!);
    sPref.setDouble('lon', lon!);
    sPref.setString('cityName', city!);
    sPref.setString('countryName', country!);
  }

  Future<void> getDataSpref() async {
    double? localLat = sPref.getDouble('lat');
    double? localLon = sPref.getDouble('lon');
    String? localCity = sPref.getString('cityName');
    String? localCountry = sPref.getString('countryName');

    setState(() {
      lat = localLat ?? 54.3108;
      lon = localLon ?? 48.3643;
      city = localCity ?? 'Ulyanovsk';
      country = localCountry ?? 'RU';
    });

    await sprefEmptyCheck();
    await fillSpref();
    setState(() {
      dataSprefGot = true;
    });
  }

  Future<void> bigFunc() async {
    // await checkConnection();
    await initSpref();
    await getDataSpref();
  }

  Future<void> getBigData() async {
    model = await NewWeatherApiClient().getWholeWeather(lat!, lon!);
  }

  Future<void> updateBigData() async {
    lat = sPref.getDouble('lat');
    lon = sPref.getDouble('lon');
    await forSetState();
  }

  Future<void> forSetState() async {
    await checkConnection();
    if(hasConnection){
      setState(() async {
        model = await NewWeatherApiClient().getWholeWeather(lat!, lon!);
      });
    }
  }

  Future<void> getLocationData() async {
    location = await NewWeatherApiClient().getLocationFromString(controller.text);
    print('city screen' + '${location!.countryName}');
  }

  Future<void> editSpref(Location location) async {
    sPref.setDouble('lat', location.lat!.toDouble());
    sPref.setDouble('lon', location.lon!.toDouble());
    sPref.setString('cityName', location.locationName!.toString());
    sPref.setString('countryName', location.countryName!.toString());
  }

  @override
  void initState() {
    bigFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода сейчас'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        leading: IconButton(
          onPressed: () {
            setState(() {
              forSetState();
            });
          }, 
          icon: Icon(Icons.restart_alt_outlined),
        ),
      ),

      //Colors.grey.shade400
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text
            //Проверка подключения
            hasConnection 
            ///Дальнешая проверка
              ? ((sprefGot && dataSprefGot) 
                //Всё есть = идем дальше
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //Тестовый текст
                    //Text('$value'),


                    FutureBuilder(
                      future: getBigData(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CurrentWeather(
                                  Icons.wb_sunny_outlined, 
                                  //'23', 
                                  model!.currentTemp.toString() + ' °C',
                                  //'Moscow'
                                  '${sPref.getString('cityName').toString()}, ${sPref.getString('countryName').toString()}',
                                  'http://openweathermap.org/img/wn/${model!.iconID}@2x.png',
                                  //'http://openweathermap.org/img/wn/13d@2x.png'
                                ),
                                SizedBox(height: 20.0,),
                                Divider(
                                  thickness: 6.0,
                                ),
                                Text(
                                  'Дополнительно',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 20.0,),
                                AdditionalInformation(
                                  model!.currentWind.toString(), 
                                  model!.currentPressure!.toDouble(),
                                  model!.currentHumidity.toString(), 
                                  model!.feelsLike.toString()
                                ),
                              ],
                            ),
                          );
                        } else{
                          return Text('Загрузка');
                        }
                      }
                    ),
                    //Text(value),



                    //Кнопка выбора города
                    /*ElevatedButton(
                      onPressed: () async {
                        location = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CityScreen(spref: sPref,),
                          ),
                        );
                        
                        setState(() {
                          updateBigData();
                          //value = spref.getString('cityName').toString();
                          //value = '${location!.lat} + ${location!.lon} \n ${location!.locationName} + ${location!.countryName}';
                        });
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
                      ),
                      child: Text('Выбрать город'),
                    ),*/


                    //Новая кнопка выбора города
                    ElevatedButton(
                      onPressed: () async {

                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          context: context, 
                          builder: (context) {
                            return Container(
                              //color: Colors.blue,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Введите название города',
                                      ),
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      controller: controller,
                                    ),
                                    ElevatedButton(
                                      /*onPressed: () async {
                                        setState(() {
                                          value = controller.text;
                                          controller.text = '';
                                        });
                                        Navigator.pop(context);
                                      },*/
                                      onPressed: () async{
                                        await getLocationData();
                                        //await sprefRewrite(controller.text);
                                        await editSpref(location!);
                                        setState(() {
                                          updateBigData();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ввод'),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );



                        /*location = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CityScreen(spref: sPref,),
                          ),
                        );*/
                        
                        /*setState(() {
                          updateBigData();
                          //value = spref.getString('cityName').toString();
                          //value = '${location!.lat} + ${location!.lon} \n ${location!.locationName} + ${location!.countryName}';
                        });*/
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
                      ),
                      child: Text('Выбрать город'),
                    ),



                    //Кнопка погоды
                    ElevatedButton(
                      onPressed: () async {
                        // await checkConnection();
                        if(hasConnection){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SecondScreen(model: model!,),
                            ));
                        }
                        else{

                        }
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
                      ),
                      child: Text('Прогноз'),
                    ),
                  ],
                ) 
                ///Всё построено

                ///Чего-то нет = загрузка
                : Column(
                  children: [
                    Text('Загрузка')
                  ],
                )
              )
            ///Дальнешая проверка



            ///Писать, что нет подключения
              : Column(
                children: [
                  Text('Нет подключения к сети!'),
                  /*ElevatedButton(
                    onPressed: () {
                      checkConnection();
                    }, 
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
                      ),
                    child: Text('Обновить')
                  )*/
                ],
              ),
            ///Писать, что нет подключения
            //Text


            /*ElevatedButton(
              onPressed: (){
                checkConnection();
              }, 
              child: Text('Update')
            ),

            ElevatedButton(
              onPressed: () async {
                latLonCity = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FieldPage(),
                  )
                );
                if(latLonCity != null){
                  setState(() {
                    lat = latLonCity!.lat ?? 0;
                    lon = latLonCity!.lon ?? 0;
                    city = latLonCity!.city ?? 'none';
                  });
                }
              }, 
              child: Text('Go'),
            )*/
          ],
        ),
      ),
    );
  }
}
