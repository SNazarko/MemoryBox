// import 'package:flutter/material.dart';
// import 'package:memory_box/models/collections_model.dart';
// import 'package:memory_box/pages/audio_recordings_page.dart';
// import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
// import 'package:memory_box/pages/authorization_page/first_page.dart';
// import 'package:memory_box/pages/home_page.dart';
// import 'package:memory_box/pages/authorization_page/initializer_widget.dart';
// import 'package:memory_box/pages/authorization_page/last_authorization_page.dart';
// import 'package:memory_box/pages/logo_page/logo_page.dart';
// import 'package:memory_box/pages/play_page.dart';
// import 'package:memory_box/pages/podborki_page/podborki/podborki.dart';
// import 'package:memory_box/pages/podborki_page/podborki_add_audio/podborki_add_audio.dart';
// import 'package:memory_box/pages/podborki_page/podborki_edit/podborki_edit.dart';
// import 'package:memory_box/pages/podborki_page/podborki_item/podborki_item_page.dart';
// import 'package:memory_box/pages/profile_page/profile.dart';
// import 'package:memory_box/pages/profile_page/profile_edit.dart';
// import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
// import 'package:memory_box/pages/recordings_page/record_page.dart';
// import 'package:memory_box/pages/save_page.dart';
// import 'package:memory_box/pages/logo_page/screensaver_page.dart';
// import 'package:memory_box/pages/test.dart';
//
// class RoutesGenerator {
//
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case FirstPage.rootName:
//         return MaterialPageRoute(builder: (_) => FirstPage());
//       case RegistrationPage.rootName:
//         return MaterialPageRoute(builder: (_) => RegistrationPage());
//       case HomePage.rootName:
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case PlayPage.rootName:
//         return MaterialPageRoute(builder: (_) => PlayPage());
//       case SavePage.rootName:
//         return MaterialPageRoute(builder: (_) => SavePage());
//       case AudioRecordingsPage.rootName:
//         return MaterialPageRoute(builder: (_) => AudioRecordingsPage());
//       case Profile.rootName:
//         return MaterialPageRoute(builder: (_) => Profile());
//       case ProfileEdit.rootName:
//         return MaterialPageRoute(builder: (_) => ProfileEdit());
//       case Podborki.rootName:
//         return MaterialPageRoute(builder: (_) => Podborki());
//       case PodborkiEdit.rootName:
//         return MaterialPageRoute(builder: (_) => PodborkiEdit());
//       case InitializerWidget.rootName:
//         return MaterialPageRoute(builder: (_) => InitializerWidget());
//       case Screensaver.rootName:
//         return MaterialPageRoute(builder: (_) => Screensaver());
//       case LogoPage.rootName:
//         return MaterialPageRoute(builder: (_) => LogoPage());
//       case FirstAuthorizationPage.rootName:
//         return MaterialPageRoute(builder: (_) => FirstAuthorizationPage());
//       case LastAuthorizationPage.rootName:
//         return MaterialPageRoute(builder: (_) => LastAuthorizationPage());
//       case RecordPage.rootName:
//         return MaterialPageRoute(builder: (_) => RecordPage());
//       case PodborkiAddAudio.rootName:
//         return MaterialPageRoute(builder: (_) => PodborkiAddAudio());
//       case PodborkiItemPage.rootName:
//         return MaterialPageRoute(builder: (_) => PodborkiItemPage());

//       case Test.rootName:
//         return MaterialPageRoute(builder: (_) => Test());
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Scaffold(
//                   body: Center(
//                     child: Text('No route defined for ${settings.name}'),
//                   ),
//                 ));
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/first_page.dart';
import 'package:memory_box/pages/authorization_page/initializer_widget.dart';
import 'package:memory_box/pages/authorization_page/last_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
import 'package:memory_box/pages/home_page.dart';
import 'package:memory_box/pages/logo_page/logo_page.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';
import 'package:memory_box/pages/main_page.dart';
import 'package:memory_box/pages/play_page.dart';
import 'package:memory_box/pages/podborki_page/podborki/podborki.dart';
import 'package:memory_box/pages/podborki_page/podborki_add_audio/podborki_add_audio.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit/podborki_edit.dart';
import 'package:memory_box/pages/podborki_page/podborki_item/podborki_item_page.dart';
import 'package:memory_box/pages/profile_page/profile.dart';
import 'package:memory_box/pages/profile_page/profile_edit.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/test.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case FirstPage.rootName:
        builder = (_) => FirstPage.create();
        break;
      case RegistrationPage.rootName:
        builder = (_) => RegistrationPage.create();
        break;
      case HomePage.rootName:
        builder = (_) => HomePage.create();
        break;
      case AudioRecordingsPage.rootName:
        builder = (_) => AudioRecordingsPage.create();
        break;
      case Profile.rootName:
        builder = (_) => Profile.create();
        break;
      case ProfileEdit.rootName:
        builder = (_) => ProfileEdit.create();
        break;
      case Podborki.rootName:
        builder = (_) => Podborki.create();
        break;
      case PodborkiEdit.rootName:
        builder = (_) => PodborkiEdit.create();
        break;
      case InitializerWidget.rootName:
        builder = (_) => InitializerWidget.create();
        break;
      case Screensaver.rootName:
        builder = (_) => Screensaver.create();
        break;
      case LogoPage.rootName:
        builder = (_) => LogoPage.create();
        break;
      case FirstAuthorizationPage.rootName:
        builder = (_) => FirstAuthorizationPage.create();
        break;
      case LastAuthorizationPage.rootName:
        builder = (_) => LastAuthorizationPage.create();
        break;
      case RecordPage.rootName:
        builder = (_) => RecordPage.create();
        break;
      case PodborkiAddAudio.rootName:
        builder = (_) => PodborkiAddAudio.create();
        break;
      case PodborkiItemPage.rootName:
        builder = (_) => PodborkiItemPage.create();
        break;
      case Main.routeName:
        builder = (_) => Main.create();
        break;
      case Test.rootName:
        builder = (_) => const Test();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
