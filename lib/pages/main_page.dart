import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/podborki_page/podborki/podborki.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'audio_recordings_page.dart';

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

  @override
  Widget build(BuildContext context) {
    final int _currentIndex =
        context.select((Navigation nc) => nc.currentIndex);

    switch (_currentIndex) {
      case 0:
        _globalKey.currentState?.pushReplacementNamed(HomePage.rootName);

        break;
      case 1:
        _globalKey.currentState?.pushReplacementNamed(Podborki.rootName);

        break;
      case 2:
        _globalKey.currentState?.pushReplacementNamed(RecordPage.rootName);

        break;
      case 3:
        _globalKey.currentState
            ?.pushReplacementNamed(AudioRecordingsPage.rootName);

        break;
      case 4:
        _globalKey.currentState?.pushReplacementNamed(Profile.rootName);

        break;
      case 5:
        // _globalKey.currentState?.pushReplacementNamed();

        break;
      case 6:
        // _globalKey.currentState
        //     ?.pushReplacementNamed();

        break;
      default:
        _globalKey.currentState?.pushReplacementNamed(HomePage.rootName);
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
          initialRoute: HomePage.rootName,
          key: _globalKey,
          onGenerateRoute: AppRouter.generateRoute,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
