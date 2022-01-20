import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/players/bloc/sound_bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:provider/provider.dart';
import 'models/data_model_user.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
