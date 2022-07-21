import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resource/app_key_name.dart';

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

  saveInfo(User user) {
    prefs!.setString(AppKeyName.uid, user.uid);
    prefs!.setString(AppKeyName.email, user.email ?? "");
    prefs!.setString(AppKeyName.displayName, user.displayName ?? "");
    prefs!.setString(AppKeyName.photoUrl, user.photoURL ?? "");
  }

  logout() async {
    prefs!.remove(AppKeyName.uid);
    prefs!.remove(AppKeyName.displayName);
    prefs!.remove(AppKeyName.email);
    prefs!.remove(AppKeyName.takeImage);
  }
}
