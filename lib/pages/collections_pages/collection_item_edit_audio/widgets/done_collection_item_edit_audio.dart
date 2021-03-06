import 'package:flutter/material.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';

import '../../../../repositories/audio_repositories.dart';

class DoneCollectionItemEditAudio extends StatefulWidget {
  const DoneCollectionItemEditAudio({
    Key? key,
    required this.id,
    required this.name,
    required this.done,
    this.audio,
    this.duration,
    this.collection,
    required this.idCollection,
  }) : super(key: key);
  final String? id;
  final String? name;
  final String? audio;
  final String? duration;
  final bool? done;
  final List? collection;
  final String idCollection;

  @override
  State<DoneCollectionItemEditAudio> createState() =>
      _DoneCollectionItemEditAudioState();
}

class _DoneCollectionItemEditAudioState
    extends State<DoneCollectionItemEditAudio> {
  final AudioRepositories _repAud = AudioRepositories();
  final CollectionsRepositories _repColl = CollectionsRepositories();

  Future<void> _onTapDone() async {
    await _repAud.addAudioCollections(widget.idCollection, widget.id!,
        widget.collection!, !widget.collection!.contains(widget.idCollection));
    await _repColl.updateQualityAndTotalTime(
      widget.idCollection,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => _onTapDone(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.colorText),
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.done,
              color: widget.collection!.contains(widget.idCollection)
                  ? AppColor.colorText
                  : AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
