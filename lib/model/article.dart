// ignore_for_file: prefer_void_to_null

class Article {
  String? uuid;
  String? title;
  String? description;
  String? keywords;
  String? snippet;
  String? url;
  String? imageUrl;
  String? language;
  String? publishedAt;
  String? source;
  List<String>? categories;
  Null relevanceScore;

  Article({
    uuid,
    title,
    description,
    keywords,
    snippet,
    url,
    imageUrl,
    language,
    publishedAt,
    source,
    categories,
    relevanceScore,
  });

  Article.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    description = json['description'];
    keywords = json['keywords'];
    snippet = json['snippet'];
    url = json['url'];
    imageUrl = json['image_url'];
    language = json['language'];
    publishedAt = json['published_at'];
    source = json['source'];
    categories = json['categories'].cast<String>();
    relevanceScore = json['relevance_score'];
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'description': description,
        'keywords': keywords,
        'snippet': snippet,
        'url': url,
        'image_url': imageUrl,
        'language': language,
        'published_at': publishedAt,
        'source': source,
        'categories': categories,
        'relevance_score': relevanceScore,
      };
}
