import 'package:fin_hub/features/news/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('should convert from and to JSON correctly', () {
      final user = UserModel(firstName: 'Victor', lastName: 'Loveday');

      final jsonString = user.toJson();
      final userFromJson = UserModel.fromJson(jsonString);

      expect(userFromJson.firstName, equals(user.firstName));
      expect(userFromJson.lastName, equals(user.lastName));
    });

    test('copyWith should override specified fields', () {
      final user = UserModel(firstName: 'Victor', lastName: 'Loveday');
      final updated = user.copyWith(firstName: 'Droid');

      expect(updated.firstName, 'Droid');
      expect(updated.lastName, 'Loveday');
    });
  });
}
