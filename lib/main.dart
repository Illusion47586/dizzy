import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/home_screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xffF92B5C),
        backgroundColor: Color(0xffF8F9FE),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'metropolis',
        brightness: Brightness.light,
      ),
      home: Home(cameras: cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}
