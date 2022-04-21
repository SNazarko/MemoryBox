import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page_not_is_authorization.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_audio.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_not_is_authorization.dart';
import 'package:provider/provider.dart';

import '../../models/view_model.dart';
import '../../repositories/audio_repositories.dart';
import '../../repositories/collections_repositories.dart';
import '../../repositories/user_repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionsRepositories repCollections = CollectionsRepositories();
  final UserRepositories repUser = UserRepositories();
  Future<void> subscriptionDone(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repCollections.user!.phoneNumber!)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final bool subscription = result.data()['subscription'] ?? true;
        if (subscription == false) {
          Provider.of<Navigation>(context, listen: false).setCurrentIndex = 7;
        }
      }
    });
  }

  @override
  void initState() {
    repUser.limitNotSubscription();
    subscriptionDone(context);
    AudioRepositories().finishDelete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                child: repUser.user == null
                    ? const AppbarHeaderHomePageNotIsAuthorization()
                    : const AppbarHeaderHomePage(),
              ),
              Expanded(
                  flex: 11,
                  child: repUser.user == null
                      ? const HomePageNotIsAuthorization()
                      : const HomePageAudio()),
            ],
          ),
        ),
      ),
    );
  }
}
