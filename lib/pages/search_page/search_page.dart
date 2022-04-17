import 'package:flutter/material.dart';
import 'package:memory_box/pages/search_page/widgets/appbar_header_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page_not_is_authorization.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/utils/constants.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';
  final UserRepositories _arg = UserRepositories();
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _arg.user == null
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
