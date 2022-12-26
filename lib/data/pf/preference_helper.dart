import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static PreferenceHelper? _preferenceHelper;

  PreferenceHelper._instance() {
    _preferenceHelper = this;
  }

  factory PreferenceHelper() =>
      _preferenceHelper ?? PreferenceHelper._instance();

  static SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get sharedPreferences async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static const _roleKey = 'ROLE';

  Future<String?> getRole() async {
    final prefs = await sharedPreferences;
    return prefs.getString(_roleKey);
  }

  Future<void> setRole(String role) async {
    final prefs = await sharedPreferences;
    prefs.remove(_roleKey);
    prefs.setString(_roleKey, role);
  }

  Future<void> removeRole() async {
    final prefs = await sharedPreferences;
    prefs.remove(_roleKey);
  }
}
