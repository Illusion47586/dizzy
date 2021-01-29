import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:dizzy/common/value-notifiers.dart';
import 'package:dizzy/functions/ball_position.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../functions/face_detector.dart';

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraWidget({this.cameras});
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController controller;
  Timer timer;
  ValueNotifier<int> counter = ValueNotifier<int>(0);
  GlobalKey _key = GlobalKey();
  Offset nosePosition;
  List<Offset> data = [];

  @override
  void initState() {
    super.initState();
    Permission.camera.request();
    for (var camera in widget.cameras) {
      Logger().v(camera.lensDirection.index);
    }
    CameraDescription selectedCamera = widget.cameras[1];
    controller = CameraController(
      selectedCamera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      foundText.value = "Not started yet";
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.stopImageStream();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return CircularProgressIndicator();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            offset: Offset(0, 5),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              key: _key,
              children: [
                CameraPreview(
                  controller,
                ),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 100,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Theme.of(context).accentColor,
                  dashRadius: 10,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                DottedLine(
                  direction: Axis.vertical,
                  lineLength: 100,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Theme.of(context).accentColor,
                  dashRadius: 10,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                ValueListenableBuilder(
                  valueListenable: position,
                  builder: (context, value, _) {
                    return AnimatedPositioned(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.easeOut,
                      top: value.y,
                      left: value.x,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xff33ff00),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.lightGreenAccent,
                            width: 5,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: counter,
            builder: (context, value, _) {
              return StepProgressIndicator(
                totalSteps: 15,
                padding: 0,
                roundedEdges: Radius.circular(20),
                currentStep: value,
                selectedColor: Color(0xff33ff00),
                unselectedColor: Colors.grey[350],
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  try {
                    Logger().v(controller.value.isStreamingImages);
                    controller.startImageStream((image) async {
                      nosePosition = await foundImage(image);
                    }).then((value) {
                      Logger().v("now: " +
                          controller.value.isStreamingImages.toString());
                    });
                    timer =
                        Timer.periodic(Duration(milliseconds: 800), (timer) {
                      try {
                        final RenderBox renderBox =
                            _key.currentContext.findRenderObject();
                        Size size = renderBox.size;
                        data.add(nosePosition);
                        position.value =
                            getBallPosition(size: size, ballSize: 30);
                        counter.value++;
                        if (counter.value > 15) {
                          controller.stopImageStream();
                          Logger().i("counter: " + counter.value.toString());
                          timer.cancel();
                          counter.value = 0;
                          print(data);
                        }
                      } catch (e) {
                        Logger().e(e);
                      }
                    });
                  } catch (e) {
                    Logger().e(e);
                  }
                },
                child: Text("Start"),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
              ),
              MaterialButton(
                onPressed: () {
                  try {
                    Logger().v(controller.value.isStreamingImages);
                    timer.cancel();
                    controller.stopImageStream().then((value) {
                      Logger().v("now: " +
                          controller.value.isStreamingImages.toString());
                    });
                    counter.value = 0;
                    print(data);
                  } catch (e) {
                    Logger().e(e);
                  } finally {
                    setState(() {});
                  }
                },
                child: Text("stop"),
                color: Colors.black,
                textColor: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
