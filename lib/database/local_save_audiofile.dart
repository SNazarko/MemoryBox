import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:permission_handler/permission_handler.dart';

import '../resources/app_colors.dart';
import '../widgets/button/alert_dialog.dart';

class LocalSaveAudioFile {
  LocalSaveAudioFile._();
  static final LocalSaveAudioFile instance = LocalSaveAudioFile._();


  // Save audio file in phone memory

  Future<void> saveAudioStorageDirectory(
      BuildContext context, String newPath, String name) async {
    Directory? directory;
    var status = await Permission.storage.shouldShowRequestRationale;
    if (status == false) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    } else {
      AlertDialogApp.instance.alertDialogPermission(
        context,
        'Разрешыть приложению доступ к фото, мультимедиа и файлам на устройстве?',
        Icons.folder_open,
      );
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
    } catch (err) {
      if (kDebugMode) {
        print("Cannot get download folder path");
      }
    }
    final filePath = directory!.path + '/$name.mp3';
    var file = File(filePath);
    var fileTemp = File(newPath);
    var isExist = await file.exists();
    if (!isExist) {
      await file.create();
    }
    var rat = await fileTemp.readAsBytes();
    await file.writeAsBytes(rat);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '$name.mp3',
        style: const TextStyle(color: AppColor.colorText),
      ),
      backgroundColor: Colors.white,
    ));
  }
}
