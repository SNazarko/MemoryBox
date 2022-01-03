import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/data_model.dart';
import 'package:memory_box/screens/profile_page/profile.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/icon_back.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  String userName = 'Андрей';
  String userNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                _AppbarHeaderProfileEdit(),
                _FotoProfilEdit(),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: TextField(
                      onChanged: (userName) {
                        context.read<DataModel>().userName(userName);
                      },
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextFieldInput(
                    onChanged: (userNumber) {
                      context.read<DataModel>().userNumber(userNumber);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(fontSize: 14, color: kColorText),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FotoProfilEdit extends StatelessWidget {
  const _FotoProfilEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 110),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppbarHeaderProfileEdit extends StatelessWidget {
  const _AppbarHeaderProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(),
        ClipPath(
          clipper: AppbarClipper(),
          child: Container(
            color: kColorAppbar,
            width: double.infinity,
            height: 250,
          ),
        ),
        IconBack(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Профиль',
              style: kTitleTextStyle2,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 75,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Твоя частчка',
              style: kTitle2TextStyle2,
            ),
          ),
        ),
      ],
    );
  }
}
