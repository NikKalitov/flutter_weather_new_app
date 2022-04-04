// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget MainPageInfo(
  IconData icon, String temp, String location, String iconID,
  String wind, String pressure, String humidity, String feelsLike){
    
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
    
  return Column(
    children: [
      Image.network(iconID),
      SizedBox(height: 5.0),
      Text(
        temp, 
        style: TextStyle(
          color: Colors.black,
          fontSize: 46.0,
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        location, 
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
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
                pressure + ' гПа', 
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
  );
  }