import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/delete_pages/widgets/appbar_header_delete_page.dart';
import 'package:memory_box/pages/delete_pages/widgets/list_players_delete_page.dart';
import 'package:memory_box/pages/delete_pages/widgets/model_delete_not_authorization.dart';
import 'package:memory_box/pages/delete_pages/widgets/popup_menu_delete_page.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:memory_box/utils/constants.dart';
import '../../Blocs/navigation_bloc/navigation__bloc.dart';
import '../../blocs/list_item_bloc/list_item_bloc.dart';
import 'bloc/delete_item_done_cubit/delete_item_done.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({Key? key}) : super(key: key);
  static const routeName = '/delete_page';
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListItemBloc>(
          create: (context) => ListItemBloc()
            ..add(
              LoadListItemEvent(
                sort: 'all',
                collection: 'DeleteCollections',
                nameSort: 'collections',
              ),
            ),
        ),
        BlocProvider<DeleteItemDoneCubit>(
          create: (context) => DeleteItemDoneCubit(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
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
            actions: [
              PopupMenuDeletePage(),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    AuthRepositories.instance.user == null
                        ? const ModelDeleteNotIsAuthorization()
                        : const ListPlayersDeletePage(),
                    const AppbarHeaderDeletePage(),
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
