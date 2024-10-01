import 'dart:async';
import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Models/Weather_Models.dart';
import 'package:weather_app/Services/Weather_Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
Weather_Services weather_services = Weather_Services('69da5085579021bc6268fbc5fe1a1e5c');
WeatherModels? _weatherModels;
String _cityName = 'Loading City..';
var lat;
var lon;
_fetchWeather() async {
  try {
    // Get current location
    final cityname = await getcurrentlocation();

    // Store the city name in the state to show in the UI
    setState(() {
      _cityName = cityname;
    });
    // Get weather of this city

    final weather = await weather_services.getweather(cityname,lat,lon);

    setState(() {
      _weatherModels = weather;
    });
  } catch (e) {
    print(e.toString());

  }
}

@override
void initState() {
  super.initState();
  _fetchWeather();
}

@override
Widget build(BuildContext context) {
  String getweatheranimation(String? maintcondition){
    if(maintcondition== null) return 'assests/sun.json';
    switch(maintcondition){
      case 'clouds':
      case 'rain':
      case 'thunders':
        return 'assests/rain.json';
      case '':
    }
  }
  return Scaffold(
    backgroundColor: Colors.black,
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor:Colors.transparent ,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      title: Text('Weather App',style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,fontSize: 30),),
      centerTitle: true,
    ),
      body:Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(2, -0.3),
            child: Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-2, -0.3),
            child: Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -1.5),
            child: Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
            ),
          ),
          BackdropFilter(
              filter:ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0),
           child:
            Container(
              decoration: BoxDecoration(
                //color: Colors.transparent,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_weatherModels!=null? _weatherModels!.Cityname.toString():
                    'Loading',style:Theme.of(context).textTheme.headlineSmall),
                    Lottie.asset('assests/cloud.json'),
                    Text(_weatherModels!=null? _weatherModels!.maincondition.toString():
                        "loading",style:Theme.of(context).textTheme.headlineSmall ),
                    Text('${_weatherModels!=null? _weatherModels!.tempture.round():
                        'loading'
                    } °C ',style:Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
  );
}
Future<String> getcurrentlocation()async{
  try{
    LocationPermission permission =await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }
    //fetch current location
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(
        const Duration(seconds: 10),
        onTimeout: (){
          throw TimeoutException('This task take more time to load');
        }
    );
    // convert the location in to list of placemark
    List<Placemark> placemark=await placemarkFromCoordinates(
        position.latitude, position.longitude);
    lat=position.latitude;
    lon=position.longitude;
    if (kDebugMode) {
      print('$lon  $lat');
    }
    // extract the city name from first placemark list
    String? cityname=placemark[0].locality;
    return cityname??'Loading...';
  }
  catch(e){
    return 'Failed to get location $e';
  }
}
}
