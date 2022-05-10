import 'package:flutter/material.dart';
import '../../../repositories/audio_repositories.dart';
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
  bool _done = false;

  Future<void> _onTapDone() async {
    _done = !_done;
    if (_done) {
      AudioRepositories.instance.doneAudioItem(
        widget.id!,
        true,
        'DeleteCollections',
      );
      setState(() {});
    }
    if (!_done) {
      AudioRepositories.instance.doneAudioItem(
        widget.id!,
        false,
        'DeleteCollections',
      );
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
            onTap: () => _onTapDone(),
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
