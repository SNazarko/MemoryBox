import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_collection_not_authorizotion.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections_not_authorizotion.dart';
import 'package:provider/provider.dart';
import 'collection_model.dart';

class _CollectionsArguments {
  _CollectionsArguments({this.auth, this.user}) {
    init();
  }
  FirebaseAuth? auth;
  User? user;

  void init() {
    auth = FirebaseAuth.instance;
    user = auth!.currentUser;
  }
}

class Collections extends StatelessWidget {
  Collections({Key? key}) : super(key: key);
  final _CollectionsArguments arguments = _CollectionsArguments();
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
            arguments.user == null
                ? const AppbarHeaderCollectionNotAuthorization()
                : const AppbarHeaderCollection(),
            arguments.user == null
                ? const ListCollectionsNotAuthorization()
                : ListCollections(),
          ],
        ),
      ),
    );
  }
}
