import 'package:flutter/material.dart';
import 'package:memory_box/pages/search_page/search_page_model.dart';
import 'package:memory_box/pages/search_page/widgets/appbar_header_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page_not_is_authorization.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchPageModel>(
      create: (BuildContext context) => SearchPageModel(),
      child: const SavePageCreate(),
    );
  }
}

class SavePageCreate extends StatelessWidget {
  const SavePageCreate({Key? key}) : super(key: key);

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
                UserRepositories().user == null
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
