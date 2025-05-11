import 'package:fin_hub/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NewsModel', () {
    test('fromJson creates correct object', () {
      final json = {
        'headline': 'Breaking News',
        'source': 'CNN',
        'image': 'image_url',
        'datetime': 1650000000,
        'url': 'https://cnn.com',
      };

      final model = NewsModel.fromJson(json);

      expect(model.headline, 'Breaking News');
      expect(model.source, 'CNN');
      expect(model.image, 'image_url');
      expect(model.date, DateTime.fromMillisecondsSinceEpoch(1650000000 * 1000));
      expect(model.url, 'https://cnn.com');
    });
  });
}