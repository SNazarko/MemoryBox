import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/screens/profile_page/profile.dart';
import 'package:memory_box/screens/screens_element/appbar_clipper.dart';
import 'package:memory_box/screens/screens_element/bottom_nav_bar.dart';
import 'package:memory_box/screens/screens_element/icon_back.dart';
import 'package:memory_box/screens/screens_element/textfield_input.dart';
import 'package:provider/provider.dart';

import '../../resources/constants.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  String? userName;
  String? userNumber;

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

class _FotoProfilEdit extends StatefulWidget {
  _FotoProfilEdit({Key? key}) : super(key: key);

  @override
  State<_FotoProfilEdit> createState() => _FotoProfilEditState();
}

class _FotoProfilEditState extends State<_FotoProfilEdit> {
  File? _image;

  Future<void> imagePicker() async {
    try {
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_image == null) return;
      final _imageTemp = File(_image.path);
      setState(() {
        this._image = _imageTemp;
        context.read<DataModel>().userImage(this._image!);
      });
    } on PlatformException catch (e) {
      print('Ошибка $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
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
              child: _image != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.asset(
                        AppIcons.avatarka,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Center(
            child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0x50000000),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Image.asset(AppIcons.camera)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160),
          child: Center(
            child: GestureDetector(
              onTap: imagePicker,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
            height: 280,
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
