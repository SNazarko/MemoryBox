import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/players/bloc/sound_bloc.dart';
import 'package:memory_box/screens/audio_recordings_page.dart';
import 'package:memory_box/screens/first_page.dart';
import 'package:memory_box/screens/home_page.dart';
import 'package:memory_box/screens/play_page.dart';
import 'package:memory_box/screens/profile_page/profile.dart';
import 'package:memory_box/screens/profile_page/profile_edit.dart';
import 'package:memory_box/screens/registration_page.dart';
import 'package:memory_box/screens/save_page.dart';
import 'package:memory_box/screens/screens_element/appbar_menu.dart';
import 'package:provider/provider.dart';

import 'bloc_all/bloc_all_bloc.dart';
import 'resources/constants.dart';
import 'data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataModel>(
        create: (BuildContext context) => DataModel(),
        child: MaterialApp(
          title: 'MemoryBox',
          theme: ThemeData(
              appBarTheme: AppBarTheme(backgroundColor: kColorAppbar),
              textTheme: const TextTheme(
                  bodyText2: TextStyle(
                      color: kColorText,
                      fontFamily: 'TTNorm',
                      fontWeight: FontWeight.normal))),
          initialRoute: '/',
          routes: {
            '/': (context) => const FirstPage(),
            '/RegistrationPage': (context) => RegistrationPage(),
            '/HomePage': (context) => HomePage(),
            '/PlayPage': (context) => PlayPage(),
            '/SavePage': (context) => SavePage(),
            '/AudioRecordingsPage': (context) => AudioRecordingsPage(),
            '/Profile': (context) => Profile(),
            '/ProfileEdit': (context) => ProfileEdit(),
          },
        ));
  }
}
