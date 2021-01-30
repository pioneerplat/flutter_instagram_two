import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    //flutter에 있는 이미지 위젯은 cache를하지않음(메모리에 저장을 하지 않음)
    //이미지를 핸드폰에 저장해 놓고 다른화면에 갔다가 다시 왔을때 저장한 이미지를 사용
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/5000/5000',
      placeholder: (BuildContext context, String url) {
        return Container(
            width: size.width,
            height: size.width,
            child: Center(
                child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black87,
                    ))));
      },
      //imageUrl에서 다운로드 받은 이미지를 imageProvider를 통해서 가져온다
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
