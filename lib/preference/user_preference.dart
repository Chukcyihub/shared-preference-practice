import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreference {
  Future<bool> saveRegisteredUser(User userData) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("name", userData.user);
    pref.setString("token", userData.token);
    return pref.commit();
  }
}
