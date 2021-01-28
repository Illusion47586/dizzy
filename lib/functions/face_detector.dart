import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import '../common/valueNotifiers.dart';

void foundImage(CameraImage image) async {
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
  faceList.value = faces;

  foundText.value = "${faces.length} people found.";

  if (faces.length > 0)
    // foundText.value = faces[0].boundingBox.toString();
    // print(faces[0].headEulerAngleZ);
    foundText.value = faces[0].smilingProbability.toString();
  else
    foundText.value = "No one is there.";
}
