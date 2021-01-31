import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar()
          ],
        ),
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
                icon: Icon(Icons.menu),
                onPressed: () {},
              )
            ],
          );
  }
}
