import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';
import 'package:memory_box/pages/first_page.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/initializer_widget.dart';
import 'package:memory_box/pages/play_page.dart';
import 'package:memory_box/pages/podborki_page/podborki.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/pages/profile_page/profile_edit.dart';
import 'package:memory_box/pages/registration_page.dart';
import 'package:memory_box/pages/save_page.dart';
import 'package:memory_box/pages/screensaver_page.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FirstPage.rootName:
        return MaterialPageRoute(builder: (_) => FirstPage());
      case RegistrationPage.rootName:
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case HomePage.rootName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case PlayPage.rootName:
        return MaterialPageRoute(builder: (_) => PlayPage());
      case SavePage.rootName:
        return MaterialPageRoute(builder: (_) => SavePage());
      case AudioRecordingsPage.rootName:
        return MaterialPageRoute(builder: (_) => AudioRecordingsPage());
      case Profile.rootName:
        return MaterialPageRoute(builder: (_) => Profile());
      case ProfileEdit.rootName:
        return MaterialPageRoute(builder: (_) => ProfileEdit());
      case Podborki.rootName:
        return MaterialPageRoute(builder: (_) => Podborki());
      case PodborkiEdit.rootName:
        return MaterialPageRoute(builder: (_) => PodborkiEdit());
      case InitializerWidget.rootName:
        return MaterialPageRoute(builder: (_) => InitializerWidget());
      case Screensaver.rootName:
        return MaterialPageRoute(builder: (_) => Screensaver());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
