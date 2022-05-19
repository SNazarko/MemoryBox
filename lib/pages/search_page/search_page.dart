import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/search_page/widgets/appbar_header_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page.dart';
import 'package:memory_box/pages/search_page/widgets/list_players_search_page_not_is_authorization.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:memory_box/utils/constants.dart';

import 'bloc/search_page/search_page_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search_page';
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPageBloc>(
      create: (context) => SearchPageBloc()
        ..add(
          const LoadSearchPageEvent(),
        ),
      child: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
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
                    AuthRepositories.instance.user == null
                        ? const ListPlayersSearchPageNotIsAuthorization()
                        : const ListPlayersSearchPage(),
                    const AppbarHeaderSearchPage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
