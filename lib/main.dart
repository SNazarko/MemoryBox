import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_page/collection_edit/collections_edit_model.dart';
import 'package:memory_box/pages/collections_page/collections_add_audio/collections_add_audio_model.dart';
import 'package:memory_box/pages/collections_page/collections_item/collections_item_page_model.dart';
import 'package:memory_box/pages/logo_page/logo_page.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:provider/provider.dart';
import 'models/view_model.dart';
import 'pages/profile_page/data_model_user.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Navigation>(
            create: (BuildContext context) => Navigation()),
        ChangeNotifierProvider<CollectionsItemPageModel>(
            create: (BuildContext context) => CollectionsItemPageModel()),
        ChangeNotifierProvider<CollectionsAddAudioModel>(
            create: (BuildContext context) => CollectionsAddAudioModel()),
        ChangeNotifierProvider<DataModel>(
            create: (BuildContext context) => DataModel()),
        ChangeNotifierProvider<CollectionsEditModel>(
          create: (BuildContext context) => CollectionsEditModel(),
        )
      ],
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
          initialRoute: LogoPage.routeName,
          onGenerateRoute: AppRouter.generateRoute),
    );
  }
}
