import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio_model.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page_model.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page_model.dart';
import 'package:memory_box/pages/delete_pages/delete_page_model.dart';
import 'package:memory_box/pages/logo_page/logo_page.dart';
import 'package:memory_box/pages/save_page/save_page_model.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:provider/provider.dart';
import 'pages/profile_pages/profile_model.dart';
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
        ChangeNotifierProvider<DeletePageModel>(
          create: (BuildContext context) => DeletePageModel(),
        ),
        ChangeNotifierProvider<SavePageModel>(
            create: (BuildContext context) => SavePageModel()),
        ChangeNotifierProvider<SearchPageModel>(
            create: (BuildContext context) => SearchPageModel()),
        ChangeNotifierProvider<CollectionItemEditPageModel>(
            create: (BuildContext context) => CollectionItemEditPageModel()),
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
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
