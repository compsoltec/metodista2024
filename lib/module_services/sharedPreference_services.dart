import 'dart:convert';

import 'package:notification2/module_home/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceModule {
  final SharedPreferences pref;
  static const String _PREF_USER = "token";
  static const String _PREF_ACESSOS = "acessos";
  static const String _PREF_ADMIN = "admin";
  SharedPreferenceModule({required this.pref});

  void clear() => pref.clear();

  void saveUserData(String userDataInJson) =>
      pref.setString(_PREF_USER, userDataInJson);
  void saveUserAcesso(List<String> userDataInJson) =>
      pref.setStringList(_PREF_ACESSOS, userDataInJson);
  void saveAdminData(String userDataInJson) =>
      pref.setString(_PREF_ADMIN, userDataInJson);

  String getUserData() {
    String userDataInJson = pref.getString(_PREF_USER) ?? "";
    return userDataInJson;
  }

  List<String> getUserAcesso() {
    List<String> userDataInJson = pref.getStringList(_PREF_ACESSOS) ?? [];
    return userDataInJson;
  }

  String getAdminData() {
    String userDataInJson = pref.getString(_PREF_ADMIN) ?? "";
    return userDataInJson;
  }
}
