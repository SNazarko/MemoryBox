import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/first_page.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/authorization_page/initializer_widget.dart';
import 'package:memory_box/pages/authorization_page/last_authorization_page.dart';
import 'package:memory_box/pages/logo_page/logo_page.dart';
import 'package:memory_box/pages/play_page.dart';
import 'package:memory_box/pages/podborki_page/podborki.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/pages/profile_page/profile_edit.dart';
import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/save_page.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';
import 'package:memory_box/pages/test.dart';

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
      case LogoPage.rootName:
        return MaterialPageRoute(builder: (_) => LogoPage());
      case FirstAuthorizationPage.rootName:
        return MaterialPageRoute(builder: (_) => FirstAuthorizationPage());
      case LastAuthorizationPage.rootName:
        return MaterialPageRoute(builder: (_) => LastAuthorizationPage());
      case RecordPage.rootName:
        return MaterialPageRoute(builder: (_) => RecordPage());
      case Test.rootName:
        return MaterialPageRoute(builder: (_) => Test());
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
