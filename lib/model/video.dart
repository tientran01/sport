class Video {
  String? name;
  String? videoUrl;
  String? thumbnailUrl;
  Video({this.name, this.videoUrl, this.thumbnailUrl});
  Video.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    videoUrl = json['videoUrl'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
