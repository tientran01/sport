import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/resource/resource.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper shared = SharedPreferencesHelper._internal();
  SharedPreferencesHelper._internal();
  SharedPreferences? prefs;

  Future<void> setUpSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  getString(String key) {
    return prefs!.getString(key);
  }

  setString(String key, String data) {
    return prefs!.setString(key, data);
  }

  getInt(String key) {
    return prefs!.getInt(key);
  }

  setInt(String key, int data) {
    return prefs!.setInt(key, data);
  }

  removeUid() async {
    prefs!.remove(AppKeyName.uid);
  }
}
