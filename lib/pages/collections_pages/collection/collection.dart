import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/collections_pages/collection/widgets/list_collections.dart';
import 'package:provider/provider.dart';

import 'collection_model.dart';

class Collections extends StatelessWidget {
  const Collections({Key? key}) : super(key: key);
  static const routeName = '/collection';
  static Widget create() {
    return ChangeNotifierProvider<CollectionModel>(
        create: (BuildContext context) => CollectionModel(),
        child: const Collections());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppbarHeaderProfile(),
            ListCollections(),
          ],
        ),
      ),
    );
  }
}
