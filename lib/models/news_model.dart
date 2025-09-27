// ignore_for_file: non_constant_identifier_names

class NewsModel {
  String? title;
  String? description;
  String? link;
  String? pubDate;
  String? source_id;
  String? image_url;

  NewsModel({
    this.title,
    this.description,
    this.link,
    this.pubDate,
    this.source_id,
    this.image_url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      description: json['description'],
      link: json['link'],
      pubDate: json['pubDate'],
      source_id: json['source_id'],
      image_url: json['image_url'],
    );
  }
}
