import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection_not_authorizotion.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections_not_authorizotion.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'blocs/item_done_cubit/item_done_cubit.dart';
import 'blocs/list_item_collection/list_item_collection_bloc.dart';

class Collections extends StatelessWidget {
  const Collections({Key? key}) : super(key: key);
  static const routeName = '/collection';
  final bool shouldPop = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemDoneCubit>(
          create: (context) => ItemDoneCubit(),
        ),
        BlocProvider<ListItemCollectionBloc>(
          create: (context) => ListItemCollectionBloc()
            ..add(const LoadListItemCollectionEvent()),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                AuthRepositories.instance.user == null
                    ? const AppbarHeaderCollectionNotAuthorization()
                    : const AppbarHeaderCollection(),
                AuthRepositories.instance.user == null
                    ? const ListCollectionsNotAuthorization()
                    : const ListCollections(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
