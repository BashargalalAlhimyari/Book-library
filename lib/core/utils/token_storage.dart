import 'package:clean_architecture/core/constants/constants.dart';
import 'package:hive/hive.dart';

class TokenStorage {
 
  static Future<void> init() async {
    await Hive.openBox(boxAutTokenhName);
  }

  static Future<void> saveToken(String token) async {
    var box = Hive.box(boxAutTokenhName);
    await box.put(tokenKey, token);
  }

  static String? getToken() {
    var box = Hive.box(boxAutTokenhName);
    return box.get(tokenKey);
  }

  static Future<void> deleteToken() async {
    var box = Hive.box(boxAutTokenhName);
    await box.delete(tokenKey);
  }
}
