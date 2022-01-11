import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/container_shadow.dart';
import 'package:memory_box/screens/screens_element/drawer_menu.dart';
import 'package:provider/provider.dart';
import '../../resources/constants.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  DataModel model = DataModel();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
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
                    '${context.watch<DataModel>().getName}',
                    style: kBodiTextStyle,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ContainerShadow(
                    width: screenWidth * 0.75,
                    height: 60.0,
                    radius: 50.0,
                    text: '${context.watch<DataModel>().getNumber}',
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
                    height: 40.0,
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
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TextLink(
                          text: 'Вийти из приложения',
                          onPressed: () => exit(0),
                        ),
                        TextButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              title: const Text(
                                'Tочно удалить аккаунт?',
                                style: TextStyle(
                                    color: Color(ColorApp.colorText),
                                    fontSize: 20.0),
                              ),
                              content: const Text(
                                'Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(ColorApp.colorText50),
                                    fontSize: 14.0),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    PreferencesDataUser().cleanKey();
                                    Phoenix.rebirth(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    child: Text(
                                      'Удалить',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(ColorApp.pink)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                          color: Color(ColorApp.pink),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      child: Text(
                                        'Нет',
                                        style: TextStyle(
                                            color: Color(ColorApp.colorText)),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(ColorApp.white100)),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: const BorderSide(
                                            color: Color(ColorApp.blue300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: const Text(
                            'Удалить аккаунт',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(ColorApp.pink),
                            ),
                          ),
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
  // File? _image;

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
                  child: Image.file(
                    context.watch<DataModel>().getUserImage,
                    fit: BoxFit.cover,
                  )
                  // _image != null
                  //     ? Image.file(
                  //         context.watch<DataModel>().getUserImage,
                  //         fit: BoxFit.cover,
                  //       )
                  //     : Image.asset(
                  //         AppIcons.avatarka,
                  //         fit: BoxFit.cover,
                  //       ),
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
