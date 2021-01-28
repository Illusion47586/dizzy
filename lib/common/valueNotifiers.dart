import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<String> foundText = ValueNotifier<String>("searching");
ValueNotifier<CameraImage> paintedImage = ValueNotifier<CameraImage>(null);
ValueNotifier<List<Face>> faceList = ValueNotifier<List<Face>>([]);
