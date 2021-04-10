// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// Project imports:
import '../common/value_notifiers.dart';
import '../model/data.dart';

Future<dynamic> foundImage(CameraImage image) async {
  final FirebaseVisionImageMetadata metadata = FirebaseVisionImageMetadata(
    rawFormat: image.format.raw,
    size: Size(
      image.width.toDouble(),
      image.height.toDouble(),
    ),
    planeData: image.planes
        .map(
          (currentPlane) => FirebaseVisionImagePlaneMetadata(
            bytesPerRow: currentPlane.bytesPerRow,
            height: currentPlane.height,
            width: currentPlane.width,
          ),
        )
        .toList(),
    rotation: ImageRotation.rotation270,
  );

  final faceDetector = FirebaseVision.instance.faceDetector(FaceDetectorOptions(
    enableClassification: true,
    enableLandmarks: true,
    enableTracking: true,
  ));

  FirebaseVisionImage visionImage = FirebaseVisionImage.fromBytes(
    image.planes[0].bytes,
    metadata,
  );

  List<Face> faces = await faceDetector.processImage(visionImage);

  foundText.value = "${faces.length} people found.";

  if (faces.length > 0) {
    Offset nosePosition =
        faces[0].getLandmark(FaceLandmarkType.noseBase).position;

    /// The [nose] is in the `viscinity of the dot` and we record the time

    int noticeRadius = 200;
    if (((nosePosition.dx - position.value.x).abs() <= noticeRadius) &&
        ((nosePosition.dy - position.value.y).abs() <= noticeRadius)) {
      Duration duration = position.value.time.difference(DateTime.now());
      if ((counter.value - 1) >= 0 && data[counter.value - 1] == 0)
        data[counter.value - 1] = duration.inMilliseconds.abs().floorToDouble();
      foundText.value = "Focus on the green dot.";
      if (counter.value > 15) foundText.value = "Your latency is $avg ms.";
    }
    return nosePosition;
  } else {
    foundText.value = "No one is there.";
    if ((counter.value - 1) >= 0 && data[counter.value - 1] == 0)
      data[counter.value - 1] = -1;
  }
}
