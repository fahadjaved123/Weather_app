import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:weather_app/Models/Weather_Models.dart';
import 'package:weather_app/Screen/Home_screen.dart';

class Weather_Services{
  static String BaseUrl='https://api.openweathermap.org/data/2.5/weather';
  final String apikey;
  Weather_Services(this.apikey);
  Future<WeatherModels> getweather(String cityname,double lat,double lon)async{
    final  response=await http.get(Uri.parse
      (
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=47f66bbe4df902807d638c3da6d3b3ac'
        // '$BaseUrl?q=$cityname&appid=$apikey&units=metric'
        )).timeout(
        const Duration(seconds: 10),
            onTimeout: (){
          throw TimeoutException('this task take more time to load');
    }
    );
    print('${response.body.toString()}');
    if(response.statusCode==200) {
      return WeatherModels.fromjson(jsonDecode(response.body.toString()));
    }
    else {
      throw Exception('Faild to load');
    }
  }
  // Future<String> getcurrentlocation()async{
  //   try{
  //     LocationPermission permission =await Geolocator.checkPermission();
  //     if(permission==LocationPermission.denied){
  //       permission=await Geolocator.requestPermission();
  //     }
  //     //fetch current location
  //     Position position=await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     ).timeout(
  //         const Duration(seconds: 10),
  //         onTimeout: (){
  //           throw TimeoutException('This task take more time to load');
  //         }
  //     );
  //     // convert the location in to list of placemark
  //     List<Placemark> placemark=await placemarkFromCoordinates(
  //         position.latitude, position.longitude);
  //
  //     // extract the city name from first placemark list
  //     String? cityname=placemark[0].locality;
  //     return cityname??'Loading...';
  //   }
  //   catch(e){
  //     return 'Failed to get location $e';
  //   }
  // }
}
