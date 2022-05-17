import 'package:shared_preferences/shared_preferences.dart';

class PreferencesDataUser {
  PreferencesDataUser._();
  static final PreferencesDataUser instance = PreferencesDataUser._();

  final _storage = SharedPreferences.getInstance();

  // Save data in SharedPreferences

  Future<void> counter(String counter) async {
    SharedPreferences storageData = await _storage;
    storageData.setString('counter_key', counter);
  }

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
