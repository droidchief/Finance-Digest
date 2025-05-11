import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserPreferences {
  static const _userKey = 'user_data';

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'firstName': user.firstName,
      'lastName': user.lastName,
    });
    await prefs.setString(_userKey, userJson);
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final data = jsonDecode(userJson);
      return UserModel(
        firstName: data['firstName'],
        lastName: data['lastName'],
      );
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
