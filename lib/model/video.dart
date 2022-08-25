class Video {
  int? id;
  String? title;
  String? videoUrl;
  String? thumbnailUrl;
  String? timeline;
  String? describe;
  bool? isFavorite;
  Video({
    this.id,
    this.title,
    this.videoUrl,
    this.thumbnailUrl,
    this.timeline,
    this.describe,
    this.isFavorite,
  });

  Video.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    videoUrl = json["videoUrl"];
    thumbnailUrl = json["thumbnailUrl"];
    timeline = json["timeline"];
    describe = json["describe"];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
        'timeline': timeline,
        'describe': describe,
      };
}
