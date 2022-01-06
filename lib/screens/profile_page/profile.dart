import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/data_model_user.dart';
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
                    height: 5,
                  ),
                  Text(
                    context.watch<DataModel>().getName,
                    style: kBodiTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ContainerShadow(
                    width: screenWidth * 0.75,
                    height: 60,
                    radius: 50,
                    text: context.watch<DataModel>().getNumber,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _TextLink(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ProfileEdit');
                    },
                    text: 'Редактировать',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const _TextLink(
                    underline: false,
                    text: 'Подписка',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _ProgressIndicator(),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _TextLink(text: 'Вийти из приложения'),
                        Text(
                          'Удалить аккаунт',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFFE27777)),
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
  const _FotoProfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
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
          child: Image.file(
            context.watch<DataModel>().getUserImage,
            width: double.infinity,
          ),
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
            height: 200,
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
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: kColorText, width: 2)),
          margin: EdgeInsets.symmetric(vertical: 5),
          width: screenWidth * 0.75,
          height: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: LinearProgressIndicator(
              value: value / 500,
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffF1B488)),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Text('$value/500 мб')
      ],
    );
  }
}
