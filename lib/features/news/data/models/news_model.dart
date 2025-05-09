class NewsModel {
  final String headline;
  final String source;
  final String image;
  final DateTime date;
  final String url;

  NewsModel({
    required this.headline,
    required this.source,
    required this.image,
    required this.date,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      headline: json['headline'],
      source: json['source'],
      image: json['image'],
      date: DateTime.fromMillisecondsSinceEpoch(json['datetime'] * 1000),
      url: json['url'],
    );
  }
}
