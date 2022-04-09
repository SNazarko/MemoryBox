import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../repositories/collections_repositories.dart';
import '../../../resources/app_colors.dart';

class IconDoneDelete extends StatefulWidget {
  const IconDoneDelete({
    Key? key,
    required this.id,
    required this.done,
    // required this.collection,
  }) : super(key: key);
  final String? id;
  // final List collection;
  final bool? done;

  @override
  State<IconDoneDelete> createState() => _IconDoneDeleteState();
}

class _IconDoneDeleteState extends State<IconDoneDelete> {
  final CollectionsRepositories repositories = CollectionsRepositories();
  bool done = false;
  String? idCollection;

  Future<void> getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(repositories.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('done', isEqualTo: true)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        idCollection = result.data()['id'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              done = !done;
              if (done) {
                repositories.doneAudioItem(
                  widget.id!,
                  true,
                  'DeleteCollections',
                );
                setState(() {});
              }
              if (!done) {
                repositories.doneAudioItem(
                  widget.id!,
                  false,
                  'DeleteCollections',
                );
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
                  color: widget.done! ? AppColor.colorText : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
