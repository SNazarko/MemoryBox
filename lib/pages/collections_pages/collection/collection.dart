import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection_not_authorizotion.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections_not_authorizotion.dart';
import 'package:memory_box/repositories/user_repositories.dart';
import 'package:provider/provider.dart';
import 'collection_model.dart';

class Collections extends StatelessWidget {
  Collections({Key? key}) : super(key: key);
  final UserRepositories rep = UserRepositories();
  static const routeName = '/collection';
  static Widget create() {
    return ChangeNotifierProvider<CollectionModel>(
        create: (BuildContext context) => CollectionModel(),
        child: Collections());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            rep.user == null
                ? const AppbarHeaderCollectionNotAuthorization()
                : const AppbarHeaderCollection(),
            rep.user == null
                ? const ListCollectionsNotAuthorization()
                : ListCollections(),
          ],
        ),
      ),
    );
  }
}
