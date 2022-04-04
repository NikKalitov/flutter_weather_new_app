// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget AdditionalInformation(
  String wind, double pressure, String humidity, String feelsLike){
  TextStyle titleFont = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    fontStyle: FontStyle.italic
  );
  TextStyle infoFont = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 15.0,
    color: Colors.black
  );


  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Ветер', 
                  style: titleFont,
                ),
                SizedBox(height: 18.0,),
                Text(
                  'Давление', 
                  style: titleFont,
                ),
                SizedBox(height: 18.0,),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  wind + ' м/с', 
                  style: infoFont,
                ),
                SizedBox(height: 18.0,),
                Text(
                  pressure.floor().toString() + ' мм.', 
                  style: infoFont,
                ),
                SizedBox(height: 18.0,),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Влажность', 
                  style: titleFont,
                ),
                SizedBox(height: 18.0,),
                Text(
                  'Ощущение', 
                  style: titleFont,
                ),
                SizedBox(height: 18.0,),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  humidity + ' %', 
                  style: infoFont,
                ),
                SizedBox(height: 18.0,),
                Text(
                  feelsLike + ' °C', 
                  style: infoFont,
                ),
                SizedBox(height: 18.0,),
              ],
            )
          ],
        ),
      ],
    ),
  );
}