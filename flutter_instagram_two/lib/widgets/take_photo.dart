import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      //현재 디바이스에서 사용가능한 카메라 목록을 가져온다
      future: availableCameras(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              width: size.width,
              height: size.width,
              color: Colors.black,
              child: (snapshot.hasData) ? _getPreview(snapshot.data) : _progress
            ),
            Expanded(
                child: OutlineButton(
                  onPressed: (){},
                  shape: CircleBorder(),
                  borderSide: BorderSide(color: Colors.black12, width: 20),
                )
            )
          ],
        );
      }
    );
  }

  _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    return FutureBuilder<void>(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        //_controller.initialize() 는 void 이기때문에 hasData로 확인할 수 없다 
        if(snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(
              _controller
          );
        } else {
          return _progress;
        }
      }
    );
  }
}
