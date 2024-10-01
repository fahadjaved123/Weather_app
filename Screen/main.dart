import 'package:flutter/material.dart';
import 'package:weather_app/Screen/Home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme:  TextTheme(
          headlineSmall: TextStyle(fontSize: 32, color: Colors.white,shadows: [
            Shadow(color: Colors.black,offset: Offset(5.0, 3.0),blurRadius: 10.0,),
          ]),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

