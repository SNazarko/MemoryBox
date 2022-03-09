import 'package:flutter/material.dart';
import 'package:memory_box/pages/search_page/widgets/appbar_header_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/popup_menu_search_page.dart';
import 'package:memory_box/resources/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';
  static Widget create() {
    return const SearchPage();
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
                ListPlayersSearchPage(),
                const AppbarHeaderSearchPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
