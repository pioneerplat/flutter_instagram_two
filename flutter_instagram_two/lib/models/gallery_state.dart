import 'package:flutter/cupertino.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:local_image_provider/local_image_provider.dart';

class GalleryState extends ChangeNotifier{
  LocalImageProvider _localImageProvider;
  bool _hasPermission;
  List<LocalImage> _images;

  Future<bool> initProvider() async {
    _localImageProvider = LocalImageProvider();
    _hasPermission = await _localImageProvider.initialize();
    if(_hasPermission){
      //디바이스에서 30개의 이미지를 가지고 와서 변수에 넣어준다
      _images = await _localImageProvider.findLatest(30);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  List<LocalImage> get images => _images;
  LocalImageProvider get localImageProvider => _localImageProvider;
}