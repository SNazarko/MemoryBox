import 'package:flutter/material.dart';
import 'package:memory_box/models/view_model.dart';
import 'package:memory_box/pages/home_page/home_page.dart';
import 'package:memory_box/pages/profile_pages/profile_model.dart';
import 'package:memory_box/pages/profile_pages/profile_page/profile.dart';
import 'package:memory_box/pages/recordings_page/record_page.dart';
import 'package:memory_box/pages/save_page/save_page_model.dart';
import 'package:memory_box/pages/search_page/search_page.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/pages/subscription_page/subscription_page.dart';
import 'package:memory_box/pages/support_message_page/support_message_page.dart';
import 'package:memory_box/routes/routes.dart';
import 'package:memory_box/widgets/bottom_nav_bar.dart';
import 'package:memory_box/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';
import '../widgets/player_collections/player_collection_model.dart';
import 'audio_recordings_page/audio_recordings_page.dart';
import 'collections_pages/collection/collection.dart';
import 'collections_pages/collection_add_audio/collections_add_audio_model.dart';
import 'collections_pages/collection_add_audio_in_collection/collection_add_audio_in_collection_model.dart';
import 'collections_pages/collection_edit/collection_edit_model.dart';
import 'collections_pages/collection_item/collections_item_page_model.dart';
import 'collections_pages/collection_item_edit/collection_item_edit_page_model.dart';
import 'delete_pages/delete_page.dart';
import 'delete_pages/delete_page_model.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  static const routeName = '/main';
  static final GlobalKey<NavigatorState> _globalKey =
      GlobalKey<NavigatorState>();
  final bool? shouldPop = false;

  static Widget create() {
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
        ),
        ChangeNotifierProvider(
          create: (_) => Navigation(),
        ),
        ChangeNotifierProvider<PlayerCollectionModel>(
          create: (_) => PlayerCollectionModel(),
        ),
        ChangeNotifierProvider<CollectionAddAudioInCollectionModel>(
          create: (BuildContext context) =>
              CollectionAddAudioInCollectionModel(),
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
      case 6:
        globalKey(SearchPage.routeName);

        break;

      case 7:
        globalKey(SubscriptionPage.routeName);

        break;
      case 8:
        globalKey(SupportMessagePage.routeName);

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
