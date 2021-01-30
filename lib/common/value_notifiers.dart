import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/enums.dart';
import '../model/position.dart';

ValueNotifier<String> foundText = ValueNotifier<String>("searching");
ValueNotifier<CameraImage> paintedImage = ValueNotifier<CameraImage>(null);
ValueNotifier<List<Face>> faceList = ValueNotifier<List<Face>>([]);
ValueNotifier<direction> rotation = ValueNotifier<direction>(null);

ValueNotifier<int> counter = ValueNotifier<int>(0);
ValueNotifier<Position> position = ValueNotifier<Position>(
  Position(
    a: 15,
    b: 15,
  ),
);
