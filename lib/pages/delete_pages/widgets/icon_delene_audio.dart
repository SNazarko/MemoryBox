import 'package:flutter/cupertino.dart';

import '../../../repositories/collections_repositories.dart';
import '../../../repositories/user_repositories.dart';
import '../../../resources/app_icons.dart';

class IconDeleteAudio extends StatelessWidget {
  const IconDeleteAudio({
    Key? key,
    required this.idAudio,
    required this.size,
  }) : super(key: key);
  final String idAudio;
  final int? size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () async {
          await UserRepositories.instance.updateSizeRepositories(-size!);
          await CollectionsRepositories.instance
              .deleteCollectionApp(idAudio, 'DeleteCollections');
        },
        child: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Image.asset(
            AppIcons.rec_delete,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
