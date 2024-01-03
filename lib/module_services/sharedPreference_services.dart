import 'dart:convert';

import 'package:notification2/module_home/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String key = 'json_data';

  Future<void> saveJson(HomeModel jsonData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(jsonData);
    prefs.setString(key, jsonString);
  }

  Future<HomeModel> loadJson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return HomeModel.fromMap(json.decode(jsonString));
    } else {
      return null!;
    }
  }
}

