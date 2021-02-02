import 'package:flutter/material.dart';
import 'package:flutter_instagram_two/constants/common_size.dart';
import 'package:flutter_instagram_two/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.letf;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            _username(),
            _userBio(),
            _editProfileBtn(),
            _tabButtons(),
            _selectedIndicator(),
          ]))
        ],
      ),
    );
  }
  Widget _selectedIndicator() {
    return Stack(
      children: [
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            alignment:
                _selectedTab == SelectedTab.letf ? Alignment.centerLeft : Alignment.centerRight,
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
              color: _selectedTab == SelectedTab.letf ? Colors.black : Colors.black26,
              onPressed: () {
                setState(() {
                  _selectedTab = SelectedTab.letf;
                });
              }),
        ),
        Expanded(
          child: IconButton(
              icon: ImageIcon(AssetImage('assets/images/saved.png')),
              color: _selectedTab == SelectedTab.letf ? Colors.black26 : Colors.black,
              onPressed: () {
                setState(() {
                  _selectedTab = SelectedTab.right;
                });
              }),
        ),
      ],
    );
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

enum SelectedTab {
  letf, right
}