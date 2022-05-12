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
      case AudioRecordingsPage.routeName:
        builder = (_) => AudioRecordingsPage();
        break;

      // authorization_pages/

      // /registration_page
      case RegistrationPage.routeName:
        builder = (_) => RegistrationPage();
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
        builder = (_) => InitializerWidget();
        break;

      // /last_authorization_page.dart
      case LastAuthorizationPage.routeName:
        builder = (_) => LastAuthorizationPage.create();
        break;

      // collections_pages/

      // /collection
      case Collections.routeName:
        builder = (_) => Collections();
        break;

      // /collection_add_audio
      case CollectionsAddAudio.routeName:
        final CollectionsAddAudioArguments args =
            arguments as CollectionsAddAudioArguments;
        builder = (_) => CollectionsAddAudio(
              titleCollections: args.titleCollections,
            );
        break;

      // /collection_add_audio_in_collection
      case CollectionAddAudioInCollection.routeName:
        final CollectionAddAudioInCollectionArgument args =
            arguments as CollectionAddAudioInCollectionArgument;
        builder = (_) => CollectionAddAudioInCollection(
              idAudio: args.idAudio,
              collectionAudio: args.collectionAudio,
            );
        break;

      // /collection_edit_dmjmkjj
      case CollectionsEdit.routeName:
        final CollectionsEditArguments args =
            arguments as CollectionsEditArguments;
        builder = (_) => CollectionsEdit(
              idCollection: args.idCollection!,
              titleCollection: args.titleCollection!,
              subTitleCollection: args.subTitleCollection!,
              imageCollection: args.imageCollection!,
            );
        break;

      // /collection_item
      case CollectionsItemPage.routeName:
        final CollectionsItemPageArguments args =
            arguments as CollectionsItemPageArguments;
        builder = (_) => CollectionsItemPage(
              qualityCollection: args.qualityCollection,
              dataCollection: args.dataCollection,
              titleCollection: args.titleCollection,
              imageCollection: args.imageCollection,
              totalTimeCollection: args.totalTimeCollection,
              subTitleCollection: args.subTitleCollection,
              idCollection: args.idCollection,
            );
        break;

      // /collection_item_edit
      case CollectionItemEditPage.routeName:
        final CollectionItemEditPageArguments args =
            arguments as CollectionItemEditPageArguments;
        builder = (_) => CollectionItemEditPage(
              subTitleCollection: args.subTitleCollection,
              qualityCollection: args.qualityCollection,
              dataCollection: args.dataCollection,
              idCollection: args.idCollection,
              totalTimeCollection: args.totalTimeCollection,
              imageCollection: args.imageCollection,
              titleCollection: args.titleCollection,
            );
        break;

      // /collection_item_edit_audio
      case CollectionItemEditAudio.routeName:
        final CollectionItemEditAudioArguments args =
            arguments as CollectionItemEditAudioArguments;
        builder = (_) => CollectionItemEditAudio(
              subTitleCollection: args.subTitleCollection,
              qualityCollection: args.qualityCollection,
              dataCollection: args.dataCollection,
              idCollection: args.idCollection,
              totalTimeCollection: args.totalTimeCollection,
              imageCollection: args.imageCollection,
              titleCollection: args.titleCollection,
            );
        break;

      // delete_pages
      case DeletePage.routeName:
        builder = (_) => DeletePage.create();
        break;

      // home_page
      case HomePage.routeName:
        builder = (_) => const HomePage();
        break;

      // profile_pages

      // /profile_edit_page
      case ProfileEdit.routeName:
        final ProfileEditArguments args = arguments as ProfileEditArguments;
        builder = (_) => ProfileEdit(
              userImage: args.userImage,
              userNumber: args.userNumber,
              userName: args.userName,
            );
        break;

      // /profile_page
      case Profile.routeName:
        builder = (_) => Profile();
        break;

      // recordings_page
      case RecordPage.routeName:
        builder = (_) => RecordPage.create();
        break;

      // save_page
      case SavePage.routeName:
        final SavePageArguments args = arguments as SavePageArguments;
        builder = (_) => SavePage(
              audioUrl: args.audioUrl,
              audioDone: args.audioDone,
              audioImage: args.audioImage,
              audioDuration: args.audioDuration,
              audioName: args.audioName,
              audioSearchName: args.audioSearchName,
              audioTime: args.audioTime,
              idAudio: args.idAudio,
              audioCollection: args.audioCollection,
            );
        break;

      // search_page
      case SearchPage.routeName:
        builder = (_) => const SearchPage();
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
      case MainPage.routeName:
        builder = (_) => const MainPage();
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
