import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/models/camera_state.dart';
import 'package:flutter_instagram_two/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: [
            //ChangeNotifierProvider로 감싼뒤 builder를 통해 내가 원하는 데이터 모델을 던져줄 수 있다
            Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child: (cameraState.isReadyToTakePhoto) ? _getPreview(
                    cameraState) : _progress
            ),
            Expanded(
                child: OutlineButton(
                  onPressed: () {
                    if (cameraState.isReadyToTakePhoto) {
                      _attemptTakePhoto()
                    }
                  },
                  shape: CircleBorder(),
                  borderSide: BorderSide(color: Colors.black12, width: 20),
                )
            )
          ],
        );
      },
    );
  }

  _getPreview(CameraState cameraState) {
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
            height: size.width / cameraState.controller.value.aspectRatio,
            child: CameraPreview(
                cameraState.controller
            ),
          ),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState) async {
    //이미지명으로 사용하기 위해
    final String timeInMilli = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    try {
      //.path를 하면 String으로 변환된다
      //await getTemporaryDirectory()).path 저장되는 폴더 위치
      //join은 String 을 합쳐주는 연산자 (path.dart)
      final path = join(
          (await getTemporaryDirectory()).path, '$timeInMilli.png');

      //사진 찍기 (path 에다가 사진을 저장한다)
      await cameraState.controller.takePicture(path);
    } catch (e) {

    }
  }
}
