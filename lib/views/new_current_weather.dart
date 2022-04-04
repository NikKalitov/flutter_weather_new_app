// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget CurrentWeather(IconData icon, String temp, String location, String iconID){
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(iconID),
        // Icon(
        //   icon, 
        //   color: Colors.orange, 
        //   size: 64.0,
        // ),
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
      ],
    ),
  );
}