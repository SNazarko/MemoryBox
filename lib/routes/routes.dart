import 'package:flutter/material.dart';
import 'package:memory_box/pages/audio_recordings_page/audio_recordings_page.dart';
import 'package:memory_box/pages/authorization_pages/first_authorization_page.dart';
import 'package:memory_box/pages/authorization_pages/first_page.dart';
import 'package:memory_box/pages/authorization_pages/initializer_widget.dart';
import 'package:memory_box/pages/authorization_pages/last_authorization_page.dart';
import 'package:memory_box/pages/authorization_pages/registration_page/registration_page.dart';
import 'package:memory_box/pages/collections_pages/collection_add_audio/collections_add_audio.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit.dart';
import 'package:memory_box/pages/collections_pages/collection_item/collections_item_page.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit/collection_item_edit_page.dart';
import 'package:memory_box/pages/collections_pages/collection/collection.dart';
import 'package:memory_box/pages/collections_pages/collection_item_edit_audio/collection_item_edit_audio.dart';
import 'package:memory_box/pages/delete_pages/delete_page.dart';
import 'package:memory_box/pages/home_page/home_page.dart';
import 'package:memory_box/pages/authorization_pages/first_wight_page.dart';
import 'package:memory_box/animation/screensaver_page/screensaver_page.dart';
import 'package:memory_box/pages/main_page.dart';
import 'package:memory_box/pages/profile_pages/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/save_page/save_page.dart';
import 'package:memory_box/pages/search_page/search_page.dart';

import '../pages/collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection.dart';
import '../pages/profile_pages/profile_edit_page/profile_edit_page.dart';
import '../pages/subscription_page/subscription_page.dart';
import '../pages/support_message_page/support_message_page.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      // audio_recordings_page
      case AudioRecordingsPage.routeName:
        builder = (_) => AudioRecordingsPage.create();
        break;

      // authorization_pages/

      // /registration_page
      case RegistrationPage.routeName:
        builder = (_) => RegistrationPage.create();
        break;

      // /first_authorization_page.dart
      case FirstAuthorizationPage.routeName:
        builder = (_) => FirstAuthorizationPage.create();
        break;

      // /first_page.dart
      case FirstPage.routeName:
        builder = (_) => FirstPage.create();
        break;

      // /first_wight_page.dart
      case FirstWightPage.routeName:
        builder = (_) => FirstWightPage.create();
        break;

      // /initializer_widget.dart
      case InitializerWidget.routeName:
        builder = (_) => InitializerWidget.create();
        break;

      // /last_authorization_page.dart
      case LastAuthorizationPage.routeName:
        builder = (_) => LastAuthorizationPage.create();
        break;

      // collections_pages/

      // /collection
      case Collections.routeName:
        builder = (_) => Collections.create();
        break;

      // /collection_add_audio
      case CollectionsAddAudio.routeName:
        builder = (_) => CollectionsAddAudio.create();
        break;

      // /collection_add_audio_in_collection
      case CollectionAddAudioInCollection.routeName:
        builder = (_) => const CollectionAddAudioInCollection();
        break;

      // /collection_edit
      case CollectionsEdit.routeName:
        builder = (_) => CollectionsEdit.create();
        break;

      // /collection_item
      case CollectionsItemPage.routeName:
        builder = (_) => CollectionsItemPage.create();
        break;

      // /collection_item_edit
      case CollectionItemEditPage.routeName:
        builder = (_) => const CollectionItemEditPage();
        break;

      // /collection_item_edit_audio
      case CollectionItemEditAudio.routeName:
        builder = (_) => const CollectionItemEditAudio();
        break;

      // delete_pages
      case DeletePage.routeName:
        builder = (_) => DeletePage();
        break;

      // home_page
      case HomePage.routeName:
        builder = (_) => HomePage.create();
        break;

      // profile_pages

      // /profile_edit_page
      case ProfileEdit.routeName:
        builder = (_) => ProfileEdit.create();
        break;

      // /profile_page
      case Profile.routeName:
        builder = (_) => Profile.create();
        break;

      // recordings_page
      case RecordPage.routeName:
        builder = (_) => RecordPage.create();
        break;

      // save_page
      case SavePage.routeName:
        final SavePage args = arguments as SavePage;
        builder = (_) => SavePage(
              duration: args.duration,
              image: args.image,
              url: args.url,
              name: args.name,
            );
        break;

      // search_page
      case SearchPage.routeName:
        builder = (_) => SearchPage();
        break;

      // subscription_page
      case SubscriptionPage.routeName:
        builder = (_) => SubscriptionPage();
        break;

      //support_message_page
      case SupportMessagePage.routeName:
        builder = (_) => SupportMessagePage();
        break;

      //screensaver_page
      case Screensaver.routeName:
        builder = (_) => Screensaver.create();
        break;

      // main_page.dart
      case Main.routeName:
        builder = (_) => Main.create();
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
