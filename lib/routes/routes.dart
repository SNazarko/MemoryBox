import 'package:flutter/material.dart';
import 'package:memory_box/screens/audio_recordings_page.dart';
import 'package:memory_box/screens/first_page.dart';
import 'package:memory_box/screens/home_page.dart';
import 'package:memory_box/screens/play_page.dart';
import 'package:memory_box/screens/profile_page/profile.dart';
import 'package:memory_box/screens/profile_page/profile_edit.dart';
import 'package:memory_box/screens/registration_page.dart';
import 'package:memory_box/screens/save_page.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FirstPage());
      case '/RegistrationPage':
        return MaterialPageRoute(builder: (_) => RegistrationPage());
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/PlayPage':
        return MaterialPageRoute(builder: (_) => PlayPage());
      case '/SavePage':
        return MaterialPageRoute(builder: (_) => SavePage());
      case '/AudioRecordingsPage':
        return MaterialPageRoute(builder: (_) => AudioRecordingsPage());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/ProfileEdit':
        return MaterialPageRoute(builder: (_) => ProfileEdit());
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
