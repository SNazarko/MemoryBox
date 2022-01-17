import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/models/preferences_data_model_user.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/resources/app_icons.dart';
import 'package:memory_box/widgets/appbar_clipper.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/icon_back.dart';
import 'package:memory_box/widgets/textfield_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/constants.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  static const rootName = '/profile_edit';
  final PreferencesDataUser _preferencesDataUser = PreferencesDataUser();

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
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 40.0,
                    child: TextField(
                      onChanged: (userName) {
                        context.read<DataModel>().userName(userName);
                      },
                      style: const TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  TextFieldInput(
                    onChanged: (userNumber) {
                      context.read<DataModel>().userNumber(userNumber);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        final String name =
                            Provider.of<DataModel>(context, listen: false)
                                .getName!;
                        _preferencesDataUser.saveName(name);
                        final String number =
                            Provider.of<DataModel>(context, listen: false)
                                .getNumber!;
                        _preferencesDataUser.saveNumber(number);
                      },
                      child: const Text(
                        'Сохранить',
                        style:
                            TextStyle(fontSize: 14, color: AppColor.colorText),
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
  String filePath = '';

  Future<void> imageadd() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool check = prefs.containsKey('image');
      if (check) {
        setState(() {
          filePath = prefs.getString('image')!;
          print('imageadd $filePath');
        });
        return;
      }

      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_image == null) return;
      String imagePath = _image.path;
      await prefs.setString('image', imagePath);
      setState(() {
        filePath = prefs.getString('image')!;
        print('imageadd2 $filePath');
        // this._image = _imageTemp;
        context.read<DataModel>().userImage(this.filePath);
      });
    } on PlatformException catch (e) {
      print('Ошибка $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageadd();
    print('ініціалізація');
  }

  // File? _image;

  Future<void> imagePicker() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_image == null) return;
      String imagePath = _image.path;
      await prefs.setString('image', imagePath);
      setState(() {
        this.filePath = imagePath;
        print('imagePicker $filePath');
        context.read<DataModel>().userImage(this.filePath);
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
          padding: const EdgeInsets.only(top: 110.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: filePath == ''
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: Image.asset(
                        AppIcons.avatarka,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: Image.file(
                        File(filePath),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110.0),
          child: Center(
            child: Container(
                width: 200.0,
                height: 200.0,
                decoration: const BoxDecoration(
                  color: AppColor.black50,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Image.asset(AppIcons.camera)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 160.0),
          child: Center(
            child: GestureDetector(
              onTap: imagePicker,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
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
            color: AppColor.colorAppbar,
            width: double.infinity,
            height: 280.0,
          ),
        ),
        IconBack(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 30.0,
            left: 10.0,
            right: 10.0,
          ),
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
            top: 75.0,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Твоя частичка',
              style: kTitle2TextStyle2,
            ),
          ),
        ),
      ],
    );
  }
}
