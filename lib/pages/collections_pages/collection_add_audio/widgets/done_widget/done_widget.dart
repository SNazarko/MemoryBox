import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

class DoneWidget extends StatefulWidget {
  const DoneWidget({
    Key? key,
    required this.id,
    required this.done,
    required this.collection,
  }) : super(key: key);
  final String? id;
  final List collection;
  final bool? done;

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  bool done = false;

  final CollectionsRepositories repositories = CollectionsRepositories();
  String? idCollection;

  Future<void> getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('titleCollections',
            isEqualTo: Provider.of<CollectionsEditModel>(context, listen: false)
                .getTitle)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        idCollection = result.data()['id'];
      }
    });
    Provider.of<CollectionsEditModel>(context, listen: false)
        .setId(idCollection!);
  }

  @override
  Widget build(BuildContext context) {
    // final bool doneProvider = context.watch<ModelDone>().getDone;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              done = !done;
              if (!done) {
                await getIdCollection(context);
                await repositories.addAudioCollections(
                  idCollection!,
                  widget.id!,
                  widget.collection,
                  false,
                );
                // context.read<ModelDone>().doneWidget();
                repositories.doneAudioItem(widget.id!, false, 'Collections');
                setState(() {});
              }
              if (done) {
                await getIdCollection(context);
                await repositories.addAudioCollections(
                    idCollection!, widget.id!, widget.collection, true);
                // context.read<ModelDone>().doneWidget();
                repositories.doneAudioItem(widget.id!, true, 'Collections');
                setState(() {});
              }
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.colorText),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.done,
                  color: done ? AppColor.colorText : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
