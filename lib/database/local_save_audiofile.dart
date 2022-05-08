import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:permission_handler/permission_handler.dart';

import '../resources/app_colors.dart';

class LocalSaveAudioFile {
  // Save audio file in phone memory

  Future<void> saveAudioStorageDirectory(
      BuildContext context, String newPath, String name) async {
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
