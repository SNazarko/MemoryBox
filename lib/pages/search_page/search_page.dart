import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/search_page/widgets/appbar_header_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page_not_is_authorization.dart';
import 'package:memory_box/pages/search_page/widgets/popup_menu_search_page.dart';
import 'package:memory_box/resources/constants.dart';

class _SearchPageArguments {
  _SearchPageArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';
  final _SearchPageArguments arguments = _SearchPageArguments();
  static Widget create() {
    return SearchPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
        title: const Text(
          'Поиск',
          style: kTitleTextStyle2,
        ),
        actions: const [PopupMenuSearchPage()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                arguments.user == null
                    ? const ListPlayersSearchPageNotIsAuthorization()
                    : ListPlayersSearchPage(),
                const AppbarHeaderSearchPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
