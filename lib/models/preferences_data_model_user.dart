import 'package:shared_preferences/shared_preferences.dart';

class PreferencesDataUser {
  final _storage = SharedPreferences.getInstance();

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
