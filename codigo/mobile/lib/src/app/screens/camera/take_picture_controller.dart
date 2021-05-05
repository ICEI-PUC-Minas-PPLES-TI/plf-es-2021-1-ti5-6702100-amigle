import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';

part 'take_picture_controller.g.dart';

class TakePictureController = _TakePictureControllerBase
    with _$TakePictureController;

abstract class _TakePictureControllerBase with Store {
  @observable
  CameraController cameraController;

  @observable
  bool cameraReady = false;

  @action
  configCamera({bool fromPin = false}) {
    cameraReady = false;
  }

  @action
  selectCamera() async {
    try {
      var cameras = await availableCameras();

      if (cameras.length > 0) {
        var selfieCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);

        if (selfieCamera == null) {
          selfieCamera = cameras.first;
        }

        print('instanciando controller');

        cameraController = CameraController(selfieCamera,
            Platform.isAndroid ? ResolutionPreset.max : ResolutionPreset.medium,
            enableAudio: false);

        print('iniciando controller');

        await cameraController.initialize().then((value) async {
          sleep(Duration(seconds: 1));

          cameraReady = true;

          print('CameraReady: $cameraReady');
        }).catchError((error) {
          print(error);
        });
      }
    } catch (error) {
      print(error);
    }
  }
}
