import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

class _HomePageArguments {
  _HomePageArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  static Widget create() {
    return HomePage();
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionsRepositories repositories = CollectionsRepositories();

  final _HomePageArguments arguments = _HomePageArguments();
  Future<void> add(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        final int totalSize = result.data()['totalSize'];
        if (totalSize >= 524288000) {
          Provider.of<Navigation>(context, listen: false).setCurrentIndex = 7;
        }
      }
    });
  }

  @override
  void initState() {
    add(context);
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
                child: arguments.user == null
                    ? const AppbarHeaderHomePageNotIsAuthorization()
                    : const AppbarHeaderHomePage(),
              ),
              Expanded(
                  flex: 11,
                  child: arguments.user == null
                      ? const HomePageNotIsAuthorization()
                      : const HomePageAudio()),
            ],
          ),
        ),
      ),
    );
  }
}
