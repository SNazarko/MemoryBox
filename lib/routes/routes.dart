import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page.dart';
import 'package:memory_box/pages/authorization_page/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/first_page.dart';
import 'package:memory_box/pages/authorization_page/initializer_widget.dart';
import 'package:memory_box/pages/authorization_page/last_authorization_page.dart';
import 'package:memory_box/pages/authorization_page/registration_page/registration_page.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/pages/delete_pages/delete_page.dart';
import 'package:memory_box/pages/home_page/home_page.dart';
import 'package:memory_box/pages/logo_page/logo_page.dart';
import 'package:memory_box/pages/logo_page/screensaver_page.dart';
import 'package:memory_box/pages/main_page.dart';
import 'package:memory_box/pages/profile_page/profile_page/profile.dart';
import 'package:memory_box/pages/profile_page/profile_edit.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/test.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case FirstPage.routeName:
        builder = (_) => FirstPage.create();
        break;
      case RegistrationPage.routeName:
        builder = (_) => RegistrationPage.create();
        break;
      case HomePage.routeName:
        builder = (_) => HomePage.create();
        break;
      case AudioRecordingsPage.routeName:
        builder = (_) => AudioRecordingsPage.create();
        break;
      case Profile.routeName:
        builder = (_) => Profile.create();
        break;
      case ProfileEdit.routeName:
        builder = (_) => ProfileEdit.create();
        break;
      case Collections.routeName:
        builder = (_) => Collections.create();
        break;
      case CollectionsEdit.routeName:
        builder = (_) => CollectionsEdit.create();
        break;
      case InitializerWidget.routeName:
        builder = (_) => InitializerWidget.create();
        break;
      case Screensaver.routeName:
        builder = (_) => Screensaver.create();
        break;
      case LogoPage.routeName:
        builder = (_) => LogoPage.create();
        break;
      case FirstAuthorizationPage.routeName:
        builder = (_) => FirstAuthorizationPage.create();
        break;
      case LastAuthorizationPage.routeName:
        builder = (_) => LastAuthorizationPage.create();
        break;
      case RecordPage.routeName:
        builder = (_) => RecordPage.create();
        break;
      case CollectionsAddAudio.routeName:
        builder = (_) => CollectionsAddAudio.create();
        break;
      case CollectionsItemPage.routeName:
        builder = (_) => CollectionsItemPage.create();
        break;
      case Main.routeName:
        builder = (_) => Main.create();
        break;
      case CollectionItemEditPage.routeName:
        builder = (_) => const CollectionItemEditPage();
        break;
      case DeletePage.routeName:
        builder = (_) => const DeletePage();
        break;
      case CollectionItemEditAudio.routeName:
        builder = (_) => const CollectionItemEditAudio();
        break;
      case Test.routeName:
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
