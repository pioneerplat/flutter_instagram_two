import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/screens/profile_screen.dart';
import 'package:flutter_instagram_two/widgets/rounded_Avatar.dart';

class ProfileBody extends StatefulWidget {
  final Function onMenuChanged; // function을 외부에서 받아오고 싶을

  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.letf;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(common_gap),
                          child: RoundedAvatar(
                            size: 80,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: common_gap),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  _valueText('111'),
                                  _valueText('222'),
                                  _valueText('333'),
                                ]),
                                TableRow(children: [
                                  _labelText('Post'),
                                  _labelText('Followers'),
                                  _labelText('Following'),
                                ]),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    _username(),
                    _userBio(),
                    _editProfileBtn(),
                    _tabButtons(),
                    _selectedIndicator(),
                  ]),
                ),
                _imagePager(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
              'Jang Woo Kun',
              textAlign: TextAlign.center,
            )),
        IconButton(
            icon: AnimatedIcon(icon: AnimatedIcons.menu_close,
              progress: _iconAnimationController,),
            //클릭이 될때마다 외부에서 받아온 functiond을 트리거한다
            onPressed: () {
              widget.onMenuChanged();
              //끝에있으면 시작지점으로 보내주고 시작에있으면 끝으로 보내준다
              _iconAnimationController.status == AnimationStatus.completed
                  ? _iconAnimationController.reverse()
                  : _iconAnimationController.forward();
            }

        )
      ],
    );
  }

  Text _valueText(String value) =>
      Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String label) =>
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagePager() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
        ],
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        30,
            (index) {
          return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: 'https://picsum.photos/id/$index/100/100');
        },
      ),
    );
  }

  Widget _selectedIndicator() {
    return Stack(
      children: [
        AnimatedContainer(
            duration: duration,
            alignment: _selectedTab == SelectedTab.letf
                ? Alignment.centerLeft
                : Alignment.centerRight,
            curve: Curves.fastOutSlowIn,
            child: Container(
              height: 3,
              width: size.width / 2,
              color: Colors.black87,
            ))
      ],
    );
  }

  Row _tabButtons() {
    return Row(
      children: [
        Expanded(
          child: IconButton(
              icon: ImageIcon(AssetImage('assets/images/grid.png')),
              color: _selectedTab == SelectedTab.letf
                  ? Colors.black
                  : Colors.black26,
              onPressed: () {
                _tabSelected(SelectedTab.letf);
              }),
        ),
        Expanded(
          child: IconButton(
              icon: ImageIcon(AssetImage('assets/images/saved.png')),
              color: _selectedTab == SelectedTab.letf
                  ? Colors.black26
                  : Colors.black,
              onPressed: () {
                _tabSelected(SelectedTab.right);
              }),
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.letf:
          _selectedTab = SelectedTab.letf;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
            onPressed: () {},
            borderSide: BorderSide(color: Colors.black45),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'username',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'this is what I believe!!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}

enum SelectedTab { letf, right }
