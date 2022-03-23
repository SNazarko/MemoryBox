import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page.dart';
import 'package:memory_box/pages/home_page/widgets/appbar_header_home_page_not_is_authorization.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_audio.dart';
import 'package:memory_box/pages/home_page/widgets/home_page_not_is_authorization.dart';

import '../../repositories/collections_repositories.dart';

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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';
  final CollectionsRepositories repositories = CollectionsRepositories();
  final _HomePageArguments arguments = _HomePageArguments();
  static Widget create() {
    return HomePage();
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
