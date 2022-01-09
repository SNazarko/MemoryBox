import 'package:shared_preferences/shared_preferences.dart';

class PreferencesDataUser {
  final storage = SharedPreferences.getInstance();

  Future<void> saveName(String name) async {
    SharedPreferences storageData = await storage;
    storageData.setString('name_key', name);
  }

  Future<String?> readName() async {
    SharedPreferences storageData = await storage;
    final name = storageData.getString('name_key');
    return name;
  }

  Future<void> saveNumber(String number) async {
    SharedPreferences storageData = await storage;
    storageData.setString('number_key', number);
  }

  Future<String?> readNumber() async {
    SharedPreferences storageData = await storage;
    final number = storageData.getString('number_key');
    return number;
  }
}
