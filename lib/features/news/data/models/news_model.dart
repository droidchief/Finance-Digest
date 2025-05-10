class NewsModel {
  final String? headline;
  final String? source;
  final String? image;
  final DateTime? date;
  final String? url;

  NewsModel({this.headline, this.source, this.image, this.date, this.url});

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

