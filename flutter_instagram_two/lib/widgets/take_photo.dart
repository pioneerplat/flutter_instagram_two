import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

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
            //ChangeNotifierProvider로 감싼뒤 builder를 통해 내가 원하는 데이터 모델을 던져줄 수 있다
            ChangeNotifierProvider(
              builder: ,
              child: Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child: (snapshot.hasData) ? _getPreview(snapshot.data) : _progress
              ),
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
          return ClipRect(
            //Overflow된 부분을 잘라준다
            child: OverflowBox(
              //center에 맞게 정렬시키고 박스 바깥으로 나갈 수 있게 해준다
              alignment: Alignment.center,
              child: FittedBox(
                //가로길이에 맞게끔 비율을 조절한다
                fit: BoxFit.fitWidth,
                child: Container(
                  width: size.width,
                  //가로로 긴 비율을 세로로 긴 비율로 바꿔준다
                  height: size.width / _controller.value.aspectRatio,
                  child: CameraPreview(
                      _controller
                  ),
                ),
              ),
            ),
          );
        } else {
          return _progress;
        }
      }
    );
  }
}
