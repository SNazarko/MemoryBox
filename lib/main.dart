import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/players/bloc/sound_bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:memory_box/screens/audio_recordings_page.dart';
import 'package:memory_box/screens/first_page.dart';
import 'package:memory_box/screens/home_page.dart';
import 'package:memory_box/screens/play_page.dart';
import 'package:memory_box/screens/profile_page/profile.dart';
import 'package:memory_box/screens/profile_page/profile_edit.dart';
import 'package:memory_box/screens/registration_page.dart';
import 'package:memory_box/screens/save_page.dart';
import 'package:provider/provider.dart';

import 'bloc_all/bloc_all_bloc.dart';
import 'resources/constants.dart';
import 'models/data_model_user.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
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
              appBarTheme:
                  const AppBarTheme(backgroundColor: AppColor.colorAppbar),
              textTheme: const TextTheme(
                  bodyText2: TextStyle(
                      color: AppColor.colorText,
                      fontFamily: 'TTNorm',
                      fontWeight: FontWeight.normal))),
          initialRoute: '/',
          onGenerateRoute: RoutesGenerator.generateRoute,
        ));
  }
}
