import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/models/audio_model.dart';
import 'package:memory_box/pages/podborki_page/podborki_edit_model.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:memory_box/widgets/done_widget/model_done.dart';
import 'package:provider/provider.dart';

class DoneWidget extends StatefulWidget {
  DoneWidget(
      {Key? key,
      required this.name,
      required this.audio,
      required this.duration,
      required this.done})
      : super(key: key);
  final String name;
  final String audio;
  final String duration;
  late final bool done;

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  Set<AudioModel> listPodbork = Set<AudioModel>();
  CollectionsRepositories repositories = CollectionsRepositories();
  bool done = false;
  int _counter = 0;
  List<int> _counterQuality = [];
  @override
  void initState() {
    done = widget.done;
    print(done);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              done = !done;
              if (done) {
                repositories.addAudioForCollection(
                  Provider.of<PodborkiEditModel>(context, listen: false)
                      .getTitle,
                  widget.name,
                  widget.audio,
                  widget.duration,
                  done,
                );
                // repositories.counterAdd(_counter);
                // // _counter = _counter + 1;
                // // _counterQuality.add(_counter);
                // // // _counter = _counterQuality.length;
                // // print(_counter);
                // // print(_counterQuality);
              }
              if (!done) {
                repositories.deleteAudioForCollection(
                  Provider.of<PodborkiEditModel>(context, listen: false)
                      .getTitle,
                  widget.name,
                );
                // repositories.counterDelete(_counter);
              }
              setState(() {});
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
