import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:dizzy/common/valueNotifiers.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../functions/face_detector.dart';

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraWidget({this.cameras});
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController controller;

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
      setState(() {});
      try {
        Logger().v(controller.value.isStreamingImages);
        controller.startImageStream((image) {
          foundImage(image);
        }).then((value) {
          Logger().v("now: " + controller.value.isStreamingImages.toString());
        });
      } catch (e) {
        Logger().e(e);
      }
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
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
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
            borderRadius: BorderRadius.circular(20),
            child: CameraPreview(controller),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  try {
                    Logger().v(controller.value.isStreamingImages);
                    controller.startImageStream((image) {
                      foundImage(image);
                    }).then((value) {
                      Logger().v("now: " +
                          controller.value.isStreamingImages.toString());
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
                  Logger().v(controller.value.isStreamingImages);
                  controller.stopImageStream();
                  Logger().v(
                      "now: " + controller.value.isStreamingImages.toString());
                },
                child: Text("stop"),
                color: Colors.black,
                textColor: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
