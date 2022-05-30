

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveSetUp {
  static Future<void> init() async {
    await Hive.initFlutter();
    await publicBoxes();
  }


  static Future<void> publicBoxes() async {
    await Hive.openBox('Authorization');
    await Hive.openBox('language');
    await Hive.openBox('themeColor');

  }
}
class AuthPrefsHelper {
  var box = Hive.box('Authorization');

  void setToken(String username) {
    box.put('apikey', username);
  }

  String? getToken() {
    return box.get('apikey');
  }

  Future<void> clearToken() async{
    await box.clear();
  }


}
class LanguageHelper{
  var box = Hive.box('language');

  void setLanguage(String username) {
    box.put('lang', username);
  }

  String? getLanguage() {
    return box.get('lang');
  }
}
class ThemeHelper{
  var box = Hive.box('themeColor');

  void setTheme(bool isDark) {
    box.put('theme', isDark);
  }

  bool getisDark() {
    if( box.get('theme') == null){
      return false;
    }
    return box.get('theme');
  }
}