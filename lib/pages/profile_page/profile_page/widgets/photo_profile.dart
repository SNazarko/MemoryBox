import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';

import '../../data_model_user.dart';

class PhotoProfileProfile extends StatelessWidget {
  const PhotoProfileProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _image = context.watch<DataModel>().getUserImage!;
    // String? _image = context.watch<DataModel>().getUserImage!;
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
                width: 200.0,
                height: 200.0,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    child: _image == 'assets/images/profile_avatar.png'
                        ? Image.asset(
                            _image,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            context.watch<DataModel>().getUserImage!,
                            fit: BoxFit.cover,
                          ))),
          ],
        ),
      ),
    );
  }
}
