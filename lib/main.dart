// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

// Project imports:
import 'view/home_screen.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
  await FlutterStatusbarManager.setColor(
    Colors.transparent,
    animated: true,
  );
  await FlutterStatusbarManager.setNavigationBarColor(
    Colors.transparent,
    animated: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 1920),
      allowFontScaling: true,
      builder: () => MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Color(0xffF92B5C),
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'metropolis',
          brightness: Brightness.light,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              alignment: Alignment.center,
              enableFeedback: true,
              elevation: MaterialStateProperty.all(20),
              shadowColor: MaterialStateProperty.all(Colors.black12),
            ),
          ),
        ),
        home: Home(cameras: cameras),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
