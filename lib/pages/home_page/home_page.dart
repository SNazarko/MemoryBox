import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page_not_is_authorization.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_audio.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_not_is_authorization.dart';
import '../../blocs/list_item_bloc/list_item_bloc.dart';
import '../../repositories/audio_repositories.dart';
import '../../repositories/auth_repositories.dart';
import '../../repositories/collections_repositories.dart';
import '../../repositories/user_repositories.dart';
import '../subscription_page/subscription_page.dart';
import 'blocs/blue _list_collections/blue_list_collections_bloc.dart';
import 'blocs/green_list_collections/green_list_collections_bloc.dart';
import 'blocs/orange_list_collections/orange_list_collections_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> subscriptionDone(BuildContext context) async {
    if (AuthRepositories.instance.user != null) {
      await FirebaseFirestore.instance
          .collection(AuthRepositories.instance.user!.phoneNumber!)
          .get()
          .then(
        (querySnapshot) {
          for (var result in querySnapshot.docs) {
            final bool subscription = result.data()['subscription'] ?? true;
            if (subscription == false) {
              Timer(const Duration(seconds: 3), () {
                Navigator.pushNamed(context, SubscriptionPage.routeName);
              });
            }
          }
        },
      );
    }
  }

  @override
  void initState() {
    UserRepositories.instance.limitNotSubscription();
    subscriptionDone(context);
    AudioRepositories.instance.finishDelete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc()
            ..add(
              LoadListItemEvent(
                sort: 'all',
                collection: 'Collections',
                nameSort: 'collections',
              ),
            ),
        ),
        BlocProvider<GreenListItemBloc>(
          create: (context) => GreenListItemBloc()
            ..add(
              LoadGreenListItemEvent(
                streamList: CollectionsRepositories.instance.readCollections(),
              ),
            ),
        ),
        BlocProvider<OrangeListItemBloc>(
          create: (context) => OrangeListItemBloc()
            ..add(
              LoadOrangeListItemEvent(
                streamList: CollectionsRepositories.instance.readCollections(),
              ),
            ),
        ),
        BlocProvider<BlueListItemBloc>(
          create: (context) => BlueListItemBloc()
            ..add(
              LoadBlueListItemEvent(
                streamList: CollectionsRepositories.instance.readCollections(),
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 0.89,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: AuthRepositories.instance.user == null
                      ? const AppbarHeaderHomePageNotIsAuthorization()
                      : const AppbarHeaderHomePage(),
                ),
                Expanded(
                  flex: 11,
                  child: AuthRepositories.instance.user == null
                      ? const HomePageNotIsAuthorization()
                      : const HomePageAudio(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
