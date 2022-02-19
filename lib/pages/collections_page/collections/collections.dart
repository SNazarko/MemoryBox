import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_page/collections/widgets/appbar_header_profile.dart';
import 'package:memory_box/pages/collections_page/collections/widgets/list_collections.dart';
import 'package:memory_box/pages/collections_page/collections_item/collections_item_page_model.dart';
import 'package:provider/provider.dart';

class Collections extends StatelessWidget {
  const Collections({Key? key}) : super(key: key);
  static const routeName = '/collections';
  static Widget create() {
    return const Collections();
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
