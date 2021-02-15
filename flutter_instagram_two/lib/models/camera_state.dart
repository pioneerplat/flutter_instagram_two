import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraState extends ChangeNotifier {
  CameraController _controller;
  CameraDescription _cameraDescription;
  bool _readyTakePhoto = false;

  void dispose() {
    if (_controller != null) _controller.dispose();
    _controller = null;
    _cameraDescription = null;
    _readyTakePhoto = false;
    //해당 데이터가 변경이 되었다는 것을 Consumer에 알려준다
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras != null && cameras.isNotEmpty) {
      setCameraDescription(cameras[0]);
    }

    bool init = false;
    while (!init) {
      init = await initialize();
    }

    _readyTakePhoto = true;
    //데이터 변화에 따른 디스플레이 업데이트를 해줘라
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initialize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  //밖에서 접근할 수 있도록
  CameraController get controller => _controller;

  CameraDescription get description => _cameraDescription;

  bool get isReadyToTakePhoto => _readyTakePhoto;
}
