import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fin_hub/features/news/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/app_config.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/dio_exception.dart';
import '../models/news_model.dart';

import 'dart:developer';

import 'package:fin_hub/features/news/data/models/user_model.dart';
import '../../../../core/network/dio_exception.dart';
import '../local/user_preferences.dart';

class UserRepository {

  Future<bool> saveUser(UserModel user) async {
    try {
      await UserPreferences.saveUser(user);
      return true;
    } catch (e, stack ) {
      debugPrintStack(stackTrace: stack);
      throw CustomException("Couldn't save user");
    }
  }

  Future<UserModel?> getSavedUser() async {
    try {
      return await UserPreferences.getUser();
    } catch (e) {
      throw CustomException("Couldn't load saved user");
    }
  }

  Future<void> clearSavedUser() async {
    await UserPreferences.clearUser();
  }
}
