import 'package:camera/camera.dart';
import 'package:dizzy/common/valueNotifiers.dart';
import 'package:flutter/material.dart';

import 'widgets/camera.dart';

class Home extends StatelessWidget {
  final List<CameraDescription> cameras;
  Home({this.cameras});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Follow the instructions, noob!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              CameraWidget(cameras: cameras),
              SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: foundText,
                builder: (context, value, w) {
                  return Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
