import 'dart:io';

import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:permission_handler/permission_handler.dart';

class LocalSaveAudioFile {
  // late final String file;

  Future<void> saveAudio(String newPath) async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    final filePath = directory.path + '/userAudio';
    // var file = File(filePath);
    var file = await File(filePath).copy(newPath);
    // var isExist = await file.exists();
    // if (!isExist) {
    //   await file.copy(newPath);
    // }
    print(file);
  }

  // String getAudioName(String filePath) {
  //   return name.split('/').last;
  // }

  Future<void> getDownloadPath(String newPath, String name) async {
    Directory? directory;
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    try {
      if (Platform.isIOS) {
        directory = await pathProvider.getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await pathProvider.getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    final filePath = directory!.path + '/$name';
    var file = File(filePath);
    var fileTemp = File(newPath);
    var isExist = await file.exists();
    if (!isExist) {
      await file.create();
    }

    var rat = await fileTemp.readAsBytes();
    var raf = await file.writeAsBytes(rat);
    // var raf = fileTemp.openSync(mode: FileMode.write);
    // raf.writeByteSync(rat);
    // await raf.close();
    // await rat.close();
    print(raf);
  }
}
