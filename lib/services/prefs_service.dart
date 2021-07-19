import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/redux/app_state.dart';

class SharePreferencesService {

  const SharePreferencesService();

  Future<String?> saveData(String key, String value) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, value);
      return null;
    } catch (e) {
      print('ERROR ON SAVE PREFS : ${e.toString()}');
      return e.toString();
    }
  }

  Future<AppState?> loadData(String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? dataString = preferences.getString(key);
      if (dataString != null && dataString.length > 0) {
        return AppState.fromJson(json.decode(dataString));
      }
      return null;
    } catch (e) {
      print('ERROR ON LOAD PREFS : ${e.toString()}');
      return null;
    }
  }

}