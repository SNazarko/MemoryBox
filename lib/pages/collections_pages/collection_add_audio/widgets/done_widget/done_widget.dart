import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/pages/collections_pages/collection_edit/collection_edit_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../repositories/audio_repositories.dart';

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
  bool _done = false;
  final AudioRepositories _repAud = AudioRepositories();
  String? idCollection;

  Future<void> _getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(_repAud.user!.phoneNumber!)
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

  Future<void> _onTapDone(BuildContext context) async {
    _done = !_done;
    if (!_done) {
      await _getIdCollection(context);
      await _repAud.addAudioCollections(
        idCollection!,
        widget.id!,
        widget.collection,
        false,
      );
      // context.read<ModelDone>().doneWidget();
      _repAud.doneAudioItem(widget.id!, false, 'Collections');
      setState(() {});
    }
    if (_done) {
      await _getIdCollection(context);
      await _repAud.addAudioCollections(
          idCollection!, widget.id!, widget.collection, true);
      // context.read<ModelDone>().doneWidget();
      _repAud.doneAudioItem(widget.id!, true, 'Collections');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bool doneProvider = context.watch<ModelDone>().getDone;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _onTapDone(context),
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
                  color: _done ? AppColor.colorText : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
