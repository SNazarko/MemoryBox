import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_box/resources/app_colors.dart';
import '../blocs/list_item_collection/list_item_collection_bloc.dart';
import 'collection_item.dart';

class ListCollections extends StatelessWidget {
  const ListCollections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90.0),
      child: BlocBuilder<ListItemCollectionBloc, ListItemCollectionState>(
        builder: (context, state) {
          if (state.status == ListItemCollectionStatus.emptyList) {
            return const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 40.0,
              ),
              child: Center(
                child: Text(
                  'Как только ты создаш колекцию, она появится здесь.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColor.colorText50,
                  ),
                ),
              ),
            );
          }
          if (state.status == ListItemCollectionStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == ListItemCollectionStatus.success) {
            return GridView.builder(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                itemCount: state.list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  crossAxisCount: 2,
                  childAspectRatio: 0.76,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final collections = state.list[index];
                  return CollectionItem(
                    id: '${collections.id}',
                    image: '${collections.avatarCollections}',
                    title: '${collections.titleCollections}',
                    subTitle: '${collections.subTitleCollections}',
                    data: '${collections.dateTime}',
                    quality: '${collections.qualityCollections}',
                    doneCollection: collections.doneCollection,
                    totalTime: '${collections.totalTime}',
                  );
                });
          }
          if (state.status == ListItemCollectionStatus.failed) {
            return const Center(
              child: Text('Ой: сталася помилка!'),
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
