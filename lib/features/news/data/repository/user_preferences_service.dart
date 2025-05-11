import '../local/user_preferences.dart';
import '../models/user_model.dart';

/// Interface for easier mocking in tests
abstract class IUserPreferencesService {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}

/// Real implementation (delegates to your existing static UserPreferences)
class UserPreferencesService implements IUserPreferencesService {
  @override
  Future<void> saveUser(UserModel user) => UserPreferences.saveUser(user);

  @override
  Future<UserModel?> getUser() => UserPreferences.getUser();

  @override
  Future<void> clearUser() => UserPreferences.clearUser();
}
