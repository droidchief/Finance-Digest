import 'package:fin_hub/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formatDate returns formatted string', () {
    final date = DateTime(2024, 1, 15);
    final result = formatDate(date);
    expect(result, '15 January 2024');
  });
}