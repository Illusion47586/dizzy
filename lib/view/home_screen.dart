import 'package:auto_size_text/auto_size_text.dart';
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
              SizedBox(height: 5),
              AutoSizeText(
                "Focus your nose on the crosshair",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: "metropolis",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
              AutoSizeText(
                "and then follow the green dot with your head.",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "metropolis",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
              SizedBox(height: 5),
              CameraWidget(cameras: cameras),
              SizedBox(height: 5),
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
