import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/audio_repositories.dart';
import '../../../../repositories/collections_repositories.dart';
import '../../../../resources/app_colors.dart';
import '../collection_add_audio_in_collection_model.dart';

class ModelAudioCollectionAddAudioInCollection extends StatefulWidget {
  ModelAudioCollectionAddAudioInCollection({
    Key? key,
    this.title,
    this.quality,
    this.image,
    this.subTitle,
    this.data,
    this.doneCollection,
    this.id,
    this.totalTime,
    required this.collectionAudio,
    required this.idAudio,
  }) : super(key: key);
  final String? id;
  final String? title;
  final String? subTitle;
  final String? quality;
  final String? image;
  final String? data;
  final String? totalTime;
  final List collectionAudio;
  final String idAudio;
  bool? doneCollection = false;

  @override
  State<ModelAudioCollectionAddAudioInCollection> createState() =>
      _ModelAudioCollectionAddAudioInCollectionState();
}

class _ModelAudioCollectionAddAudioInCollectionState
    extends State<ModelAudioCollectionAddAudioInCollection> {
  final CollectionsRepositories _repColl = CollectionsRepositories();
  final AudioRepositories _repAud = AudioRepositories();
  final bool done = true;
  @override
  void initState() {
    final List collectionAudio = widget.collectionAudio;
    collectionAudio.contains(widget.id)
        ? _repColl.doneCollections(
            widget.id!,
            true,
          )
        : _repColl.doneCollections(
            widget.id!,
            false,
          );
    super.initState();
  }

  Future<void> _onPressedDone(BuildContext context) async {
    widget.doneCollection = !widget.doneCollection!;
    if (!widget.doneCollection!) {
      await _repColl.doneCollections(
        widget.id!,
        false,
      );
      await _repAud.addAudioCollections(
        widget.id!,
        widget.idAudio,
        widget.collectionAudio,
        false,
      );
      await _repColl.updateQualityAndTotalTime(
        widget.id!,
      );
    }
    if (widget.doneCollection!) {
      await _repColl.doneCollections(
        widget.id!,
        true,
      );
      await _repAud.addAudioCollections(
        widget.id!,
        widget.idAudio,
        widget.collectionAudio,
        true,
      );
      await _repColl.updateQualityAndTotalTime(
        widget.id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: Container(
        width: 185.0,
        height: 250.0,
        color: Colors.grey,
        child: Stack(
          children: [
            widget.image != ''
                ? Image.network(
                    widget.image!,
                    fit: BoxFit.fill,
                    width: 185.0,
                    height: 250.0,
                  )
                : Container(
                    width: 185.0,
                    height: 250.0,
                    color: Colors.grey,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 10,
                    child: Text(
                      widget.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white100,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.quality} аудио',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        ),
                        Text(
                          '${widget.totalTime} часа',
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white100,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 185.0,
              height: 250.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                gradient: LinearGradient(
                    colors: widget.doneCollection!
                        ? [const Color(0xFF000000), const Color(0xFF000000)]
                        : [const Color(0xFF000000), const Color(0xFF454545)],
                    begin: Alignment.bottomRight),
              ),
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onPressedDone(context),
                    icon: Icon(
                      Icons.done,
                      color: widget.doneCollection!
                          // done
                          // context.watch<ModelPlayerMiniPodborki>().done
                          ? AppColor.white
                          : AppColor.glass,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
