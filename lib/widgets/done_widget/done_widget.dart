import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/done_widget/model_done.dart';
import 'package:provider/provider.dart';

class DoneWidget extends StatefulWidget {
  DoneWidget(
      {Key? key,
      required this.name,
      required this.audio,
      required this.duration})
      : super(key: key);
  final String name;
  final String audio;
  final String duration;

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  Set<AudioModel> listPodbork = Set<AudioModel>();
  // List<AudioModel> listPodborki = [];
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              done = !done;
              // final audio = AudioModel(
              //   audioName: widget.name,
              //   audioUrl: widget.audio,
              //   duration: widget.duration,
              // );
              // final json = audio.toJson();
              if (done) {
                CollectionsRepositories().addAudioForCollection(
                    widget.name, widget.audio, widget.duration);
                // listPodborki.add(json);
                // print(listPodborki);
              }
              if (!done) {
                // listPodborki.remove(audio);
                // print(listPodborki);
              }

              setState(() {});
              // Provider.of<ModelPlayerMiniPodborki>(context, listen: false)
              //     .doneWidget();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.colorText),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.done,
                  color: done
                      // context.watch<ModelPlayerMiniPodborki>().done
                      ? AppColor.colorText
                      : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
