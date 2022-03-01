import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/resources/app_colors.dart';

class DoneCollectionItemEditAudio extends StatefulWidget {
  const DoneCollectionItemEditAudio(
      {Key? key,
      required this.name,
      required this.done,
      this.audio,
      this.duration})
      : super(key: key);
  final String? name;
  final String? audio;
  final String? duration;
  final bool? done;

  @override
  State<DoneCollectionItemEditAudio> createState() =>
      _DoneCollectionItemEditAudioState();
}

class _DoneCollectionItemEditAudioState
    extends State<DoneCollectionItemEditAudio> {
  // final CollectionsRepositories repositories = CollectionsRepositories();

  @override
  Widget build(BuildContext context) {
    // final bool doneProvider = context.watch<ModelDone>().getDone;
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
            color: widget.done! ? AppColor.colorText : AppColor.white,
          ),
        ),
      ),
    );

    //   Padding(
    //   padding: const EdgeInsets.all(0.0),
    //   child: Stack(
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           repositories.doneAudioItem(widget.name!, doneProvider);
    //           context.read<ModelDone>().doneWidget();
    //           done = !done;
    //           if (done) {
    //             repositories.addAudioForCollection(
    //               Provider.of<CollectionsEditModel>(context, listen: false)
    //                   .getTitle,
    //               widget.name!,
    //               widget.audio!,
    //               widget.duration!,
    //               done,
    //             );
    //           }
    //           if (!done) {
    //             repositories.deleteAudioForCollection(
    //               Provider.of<CollectionsEditModel>(context, listen: false)
    //                   .getTitle,
    //               widget.name!,
    //             );
    //           }
    //         },
    //         child: Container(
    //           width: 30,
    //           height: 30,
    //           decoration: BoxDecoration(
    //             border: Border.all(color: AppColor.colorText),
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(25.0),
    //             ),
    //           ),
    //           child: Center(
    //             child: Icon(
    //               Icons.done,
    //               color: done ? AppColor.colorText : AppColor.white,
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
