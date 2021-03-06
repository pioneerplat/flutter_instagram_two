import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/comment.dart';
import 'package:flutter_instagram_two/widgets/my_progress_indicator.dart';
import 'package:flutter_instagram_two/widgets/rounded_Avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postAction(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postAction() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
          color: Colors.black87,
        ),
        Spacer(),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text("username")),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  //flutter에 있는 이미지 위젯은 cache를하지않음(메모리에 저장을 하지 않음)
  //이미지를 핸드폰에 저장해 놓고 다른화면에 갔다가 다시 왔을때 저장한 이미지를 사용
  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/1000/1000',
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(containerSize: size.width);
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

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(showImage: false, username: 'wookun', text: 'I have money!!!',),
    );
  }
}


