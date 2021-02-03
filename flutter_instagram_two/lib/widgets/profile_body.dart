import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';
import 'package:flutter_instagram_two/widgets/rounded_Avatar.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.letf;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String label) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  SliverToBoxAdapter _imagePager() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
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
            duration: Duration(milliseconds: 300),
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
