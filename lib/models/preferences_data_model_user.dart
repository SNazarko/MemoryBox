import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class PreferencesDataUser {
  final _storage = SharedPreferences.getInstance();
  // late final String file;
  //
  // Future<void> saveImages(File newPath) async {
  //   final directory = await pathProvider.getApplicationDocumentsDirectory();
  //   final filePath = directory.path + '/imagesUser';
  //   var file = File(filePath);
  //   var isExist = await file.exists();
  //   if (!isExist) {
  //     await file.readAsBytes();
  //   }
  // }

  Future<void> saveName(String name) async {
    SharedPreferences storageData = await _storage;
    storageData.setString('name_key', name);
  }

  Future<void> saveNumber(String number) async {
    SharedPreferences storageData = await _storage;
    storageData.setString('number_key', number);
  }

  Future<void> cleanKey() async {
    SharedPreferences storageData = await _storage;
    storageData.clear();
  }
}
