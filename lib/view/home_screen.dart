import 'package:boxicons_flutter/boxicons_flutter.dart';
import 'package:camera/camera.dart';
import '../model/data.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../common/value_notifiers.dart';
import 'widgets/camera.dart';

class Home extends StatelessWidget {
  final List<CameraDescription> cameras;
  Home({this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            40,
            30,
            40,
            40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyAppBar(),
              RichText(
                text: TextSpan(
                  text: "Focus your nose on the ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "metropolis",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                  children: [
                    TextSpan(
                      text: "crosshair",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextSpan(
                      text: "\nand then follow the green dot.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              CameraWidget(cameras: cameras),
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

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: "Dizzy\n",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "metropolis",
                fontWeight: FontWeight.w400,
                fontSize: 40,
                height: 1.1,
              ),
              children: [
                TextSpan(
                  text: "Check",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 45,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Boxicons.bxShareAlt,
              size: 30,
            ),
            onPressed: () {
              Share.share('My latency is $avg ms.');
            },
          ),
        ],
      ),
    );
  }
}
