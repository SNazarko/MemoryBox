import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/models/data_model_user.dart';
import 'package:memory_box/models/user_model.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';
import 'package:memory_box/resources/app_colors.dart';

import '../authorization_page/first_page.dart';

class LogoPage extends StatefulWidget {
  LogoPage({Key? key}) : super(key: key);
  static const rootName = 'logo_page';
  DataModel _dataModel = DataModel();
  AudioModel _audioModel = AudioModel();
  UserModel _userModel = UserModel();

  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushNamed(context, Screensaver.rootName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF8077E4),
      ),
    );
  }
}
