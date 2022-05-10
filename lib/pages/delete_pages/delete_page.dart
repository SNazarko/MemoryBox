import 'package:flutter/material.dart';
import 'package:memory_box/pages/delete_pages/widgets/appbar_header_delete_page.dart';
import 'package:memory_box/pages/delete_pages/widgets/list_players_delete_page.dart';
import 'package:memory_box/pages/delete_pages/widgets/model_delete_not_authorization.dart';
import 'package:memory_box/pages/delete_pages/widgets/popup_menu_delete_page.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import 'package:provider/provider.dart';

import 'delete_page_model.dart';

class DeletePage extends StatelessWidget {
  DeletePage({Key? key}) : super(key: key);
  static const routeName = '/delete_page';
  static Widget create() {
    return ChangeNotifierProvider<DeletePageModel>(
      create: (BuildContext context) => DeletePageModel(),
      child: DeletePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        elevation: 0.0,
        centerTitle: true,

        title: const Text(
          'Недавно',
          style: kTitleTextStyle2,
        ),
        actions: [PopupMenuDeletePage()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                AuthRepositories.instance.user == null
                    ? const ModelDeleteNotIsAuthorization()
                    : ListPlayersDeletePage(),
                const AppbarHeaderDeletePage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
