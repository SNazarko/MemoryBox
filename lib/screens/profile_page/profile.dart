import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/container_shadow.dart';
import 'package:memory_box/screens/screens_element/drawer_menu.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';
import 'package:provider/provider.dart';

import '../../resources/constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Профиль',
          style: kTitleTextStyle2,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                _AppbarHeaderProfile(),
                _FotoProfil(),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    context.watch<DataModel>().getName,
                    style: kBodiTextStyle,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ContainerShadow(
                    width: screenWidth * 0.75,
                    height: 60.0,
                    radius: 50.0,
                    text: context.watch<DataModel>().getNumber,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  _TextLink(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ProfileEdit');
                    },
                    text: 'Редактировать',
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const _TextLink(
                    underline: false,
                    text: 'Подписка',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  _ProgressIndicator(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TextLink(
                          text: 'Вийти из приложения',
                          onPressed: () {},
                        ),
                        const Text(
                          'Удалить аккаунт',
                          style: TextStyle(
                              fontSize: 14.0, color: Color(ColorApp.pink)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FotoProfil extends StatelessWidget {
  _FotoProfil({Key? key}) : super(key: key);
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: _image != null
                    ? Image.file(
                        context.watch<DataModel>().getUserImage,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AppIcons.avatarka,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppbarHeaderProfile extends StatelessWidget {
  const _AppbarHeaderProfile({Key? key}) : super(key: key);

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
            height: 200.0,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Твоя частчка',
            style: kTitle2TextStyle2,
          ),
        ),
      ],
    );
  }
}

class _TextLink extends StatelessWidget {
  const _TextLink(
      {Key? key, required this.text, this.onPressed, this.underline = true})
      : super(key: key);
  final String text;
  final onPressed;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: underline ? kBodi2TextStyle : kBodiOverlineTextStyle,
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);
  final int value = 150;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0),
              ),
              border: Border.all(color: kColorText, width: 2.0)),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          width: screenWidth * 0.75,
          height: 30.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: LinearProgressIndicator(
              value: value / 500,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(ColorApp.yellow100),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Text('$value/500 мб')
      ],
    );
  }
}
