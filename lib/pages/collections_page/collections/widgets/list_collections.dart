import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/collections_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';

import 'collections_item.dart';

class ListCollections extends StatelessWidget {
  ListCollections({Key? key}) : super(key: key);
  final CollectionsRepositories repositories = CollectionsRepositories();

  Widget buildCollections(CollectionsModel collections) => CollectionsItem(
        image: '${collections.avatarCollections}',
        title: '${collections.titleCollections}',
        subTitle: '${collections.subTitleCollections}',
        data: '${collections.data}',
        quality: '${collections.qualityCollections}',
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: StreamBuilder<List<CollectionsModel>>(
        stream: repositories.readCollections(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Ошибка');
          }
          if (snapshot.hasData) {
            final collections = snapshot.data!;
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              crossAxisCount: 2,
              childAspectRatio: 0.76,
              children: collections.map(buildCollections).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
