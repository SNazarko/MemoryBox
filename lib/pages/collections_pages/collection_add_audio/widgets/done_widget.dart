import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/auth_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import '../../../../repositories/audio_repositories.dart';

class DoneWidget extends StatefulWidget {
  const DoneWidget({
    Key? key,
    required this.id,
    required this.done,
    required this.collection,
    required this.titleCollections,
  }) : super(key: key);
  final String id;
  final String titleCollections;
  final List collection;
  final bool? done;

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  bool _done = false;
  String? idCollection;

  Future<void> _getIdCollection(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(AuthRepositories.instance.user!.phoneNumber!)
        .doc('id')
        .collection('CollectionsTale')
        .where('titleCollections', isEqualTo: widget.titleCollections)
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        idCollection = result.data()['id'];
      }
    });
  }

  Future<void> _onTapDone(BuildContext context) async {
    _done = !_done;
    if (!_done) {
      await _getIdCollection(context);
      await AudioRepositories.instance.addAudioCollections(
        idCollection!,
        widget.id,
        widget.collection,
        false,
      );
      AudioRepositories.instance.doneAudioItem(widget.id, false, 'Collections');
      setState(() {});
    }
    if (_done) {
      await _getIdCollection(context);
      await AudioRepositories.instance.addAudioCollections(
          idCollection!, widget.id, widget.collection, true);
      AudioRepositories.instance.doneAudioItem(widget.id, true, 'Collections');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
