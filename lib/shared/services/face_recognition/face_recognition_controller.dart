import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:get/get.dart';

class FaceRecognitionController extends GetxController {
  FaceRecognitionController();

  Rx<File>? faceCameraCapture = Rx<File>(File(""));

  late FaceCameraController faceCameraController;

  @override
  void onInit() async {
    super.onInit();
    initCamera();
    faceCameraController = FaceCameraController(
      autoCapture: false,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
        faceCameraCapture?.value = image ?? File('');
      },
      onFaceDetected: (Face? face) {
        //Do something
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> initCamera() async {
    await FaceCamera.initialize();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
