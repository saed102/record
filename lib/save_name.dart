import 'package:recordapp/view/recorder_home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class savedata {
  static late SharedPreferences save;

  static init() async {
    return save = await SharedPreferences.getInstance();
  }

  static Future savenamed(n) async {
    return await save.setStringList("key", n);
  }
  static Future removesavenamed() async {
    return await save.remove("key");
  }

  static Future<List<String>?> getnamed(key) async {
    return await save.getStringList(key);
  }

  static Future iteamsdeled(n) async {
    return await save.setStringList("key2", n);
  }
  static Future removeiteamsdeled() async {
    return await save.remove("key2");
  }

  static Future<List<String>?> getiteamsdeled(key) async {
    return await save.getStringList(key);
  }
}
