import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_box/repositories/collections_repositories.dart';
import 'package:memory_box/resources/app_colors.dart';
import 'package:provider/provider.dart';

import 'model_done.dart';

class DoneWidget extends StatelessWidget {
  DoneWidget({Key? key, required this.name, required this.done})
      : super(key: key);
  final String? name;
  final bool? done;
  final CollectionsRepositories repositories = CollectionsRepositories();

  @override
  Widget build(BuildContext context) {
    final bool doneProvider = context.watch<ModelDone>().getDone;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              repositories.doneAudioItem(name!, doneProvider);
              context.read<ModelDone>().doneWidget();
              // done = !done!;
              // if (done) {
              //   repositories.addAudioForCollection(
              //     Provider.of<CollectionsEditModel>(context, listen: false)
              //         .getTitle,
              //     name,
              //     audio,
              //     duration,
              //     done!,
              //   );
              // }
              // if (!done!) {
              //   repositories.deleteAudioForCollection(
              //     Provider.of<CollectionsEditModel>(context, listen: false)
              //         .getTitle,
              //     name,
              //   );
              // }
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
                  color: done ?? false ? AppColor.colorText : AppColor.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
