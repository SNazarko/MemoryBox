import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/home_page/home_page.dart';
import 'package:memory_box/pages/profile_page/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'audio_recordings_page/audio_recordings_page.dart';
import 'collections_pages/collection/collection.dart';
import 'delete_pages/delete_page.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  static const routeName = '/main';
  static final GlobalKey<NavigatorState> _globalKey =
      GlobalKey<NavigatorState>();
  final bool? shouldPop = false;

  static Widget create() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Navigation(),
        ),
      ],
      child: const Main(),
    );
  }

  void globalKey(route) {
    _globalKey.currentState?.pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final int _currentIndex =
        context.select((Navigation nc) => nc.currentIndex);

    switch (_currentIndex) {
      case 0:
        globalKey(HomePage.routeName);

        break;
      case 1:
        globalKey(Collections.routeName);

        break;
      case 2:
        globalKey(RecordPage.routeName);

        break;
      case 3:
        globalKey(AudioRecordingsPage.routeName);

        break;
      case 4:
        globalKey(Profile.routeName);

        break;
      case 5:
        globalKey(DeletePage.routeName);

        break;

      default:
        globalKey(HomePage.routeName);
        break;
    }

    return WillPopScope(
      onWillPop: () async {
        return shouldPop!;
      },
      child: Scaffold(
        drawer: const DrawerMenu(),
        extendBody: true,
        body: Navigator(
          initialRoute: HomePage.routeName,
          key: _globalKey,
          onGenerateRoute: AppRouter.generateRoute,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
