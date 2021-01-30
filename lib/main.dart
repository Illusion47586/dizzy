import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'view/home_screen.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool check = await Permission.camera.isGranted;
  while (!check) Permission.camera.request();
  cameras = await availableCameras();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
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
