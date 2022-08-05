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

  static List<Video> videos = [
    Video(
      name: "Stocks making the biggest moves premarket: Eli Lilly, Cigna, Restaurant Brands and more - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    ),
    Video(
      name: "BOE Raises Rates by Most Since 1995, Warns of Long Recession - Bloomberg",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    ),
    Video(
      name: "For Bigger Blazes",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
    ),
    Video(
      name: "For Bigger Escape",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
    ),
    Video(
      name: "Restaurant Brands International earnings top estimates, fueled by stronger Tim Hortons, Burger King sales - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
    ),
    Video(
      name: "Alibaba shares pop 5% after earnings beat — but reports first flat revenue growth in history - CNBC",
      videoUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      thumbnailUrl:
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
    ),
  ];
}
