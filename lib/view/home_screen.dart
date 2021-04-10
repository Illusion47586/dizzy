// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../common/value_notifiers.dart';
import 'widgets/appbar.dart';
import 'widgets/camera.dart';

class Home extends StatelessWidget {
  final List<CameraDescription> cameras;
  Home({this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 80.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 80.h),
                MyAppBar(),
                AutoSizeText.rich(
                  TextSpan(
                    text: "Focus your nose on the crosshair\n",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: "metropolis",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: "and then follow the green dot with your head.",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "metropolis",
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
                CameraWidget(cameras: cameras),
                SizedBox(height: 60.h),
                ValueListenableBuilder(
                  valueListenable: foundText,
                  builder: (context, value, w) {
                    return Text(
                      "Debug text: $value",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    );
                  },
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
