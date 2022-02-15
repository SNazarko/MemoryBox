import 'package:flutter/cupertino.dart';
import 'package:memory_box/widgets/container_shadow.dart';

class FotoContainer extends StatelessWidget {
  FotoContainer({Key? key}) : super(key: key);
  String? singleImage;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 130.0,
        right: 15.0,
      ),
      child: ContainerShadow(
        image: Image.network(
          'https://firebasestorage.googleapis.com/v0/b/memory-box-6cb96.appspot.com/o/userAudio%2Faudio1821989074040555513.m4a?alt=media&token=391d314b-7a2b-49cb-8bf6-09d28c7fe067',
          fit: BoxFit.fitWidth,
        ),
        width: screenWidth * 0.955,
        height: 200.0,
        widget: const Text(''),
        radius: 20.0,
      ),
    );
  }
}
