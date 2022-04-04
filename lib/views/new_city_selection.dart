// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_weather_new_app/model/new_location_model.dart';
import 'package:flutter_weather_new_app/services/new_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({ 
    Key? key,
    required this.spref
  }) : super(key: key);

  final SharedPreferences spref;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  TextEditingController controller = TextEditingController();
  late SharedPreferences newSpref;
  Location? location = Location();
  //Location? location2 = Location();

  Future<void> initSpref() async {
    newSpref = await SharedPreferences.getInstance();
  }

  Future<void> getLocationData() async {
    location = await NewWeatherApiClient().getLocationFromString(controller.text);
    print('city screen' + '${location!.countryName}');
  }

  Future<void> editSpref(Location location) async {
    widget.spref.setDouble('lat', location.lat!.toDouble());
    widget.spref.setDouble('lon', location.lon!.toDouble());
    widget.spref.setString('cityName', location.locationName!.toString());
    widget.spref.setString('countryName', location.countryName!.toString());
  }

  @override
  void initState() {
    initSpref();
    //getLocationData();
    super.initState();
  }

  Future<void> sprefRewrite(String value) async {
    newSpref.setString('cityName', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбрать город'), 
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
      ),
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Введите название города',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                await getLocationData();
                //await sprefRewrite(controller.text);
                await editSpref(location!);
                Navigator.of(context).pop(location);
              }, 
              child: Text('Далее'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey.shade800)
              ),
            )
          ],
        ),
      ),
    );
  }
}