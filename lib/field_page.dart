// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_weather_new_app/latloncity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({ Key? key }) : super(key: key);

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {

  SharedPreferences? sPref;
  LatLonCity latLonCity = LatLonCity();
  TextEditingController latCtrl = TextEditingController();
  TextEditingController lonCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  Future<void> initSpref() async {
    sPref = await SharedPreferences.getInstance();
  }

  Future<void> fillClass() async {
    latLonCity.lat = double.tryParse(latCtrl.text);
    latLonCity.lon = double.tryParse(lonCtrl.text);
    latLonCity.city = cityCtrl.text;
    await fillSpref(latLonCity.lat, latLonCity.lon, latLonCity.city);
  }

  Future<void> fillSpref(double? lat, double? lon, String? city) async {
    sPref!.setDouble('lat', lat!);
    sPref!.setDouble('lon', lon!);
    sPref!.setString('city', city!);
  }

  @override
  void initState() {
    initSpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Field page'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: latCtrl,
              decoration: InputDecoration(
                hintText: 'lat',
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: lonCtrl,
              decoration: InputDecoration(
                hintText: 'lon'
              ),
              textAlign: TextAlign.center
            ),
            TextField(
              controller: cityCtrl,
              decoration: InputDecoration(
                hintText: 'city'
              ),
              textAlign: TextAlign.center
            ),
            ElevatedButton(
              onPressed: () async {
                await fillClass();
                Navigator.of(context).pop(latLonCity);
              }, 
              child: Text('Done')
            ),
          ],
        ),
      ),
    );
  }
}