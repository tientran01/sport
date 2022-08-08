import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_app/model/article.dart';
import 'package:sport_app/model/video.dart';
import 'package:sport_app/resource/resource.dart';

class FavoriteBox {
  static FavoriteBox shared = FavoriteBox.internal();
  FavoriteBox.internal();

  late Box box;
  List<Video?>? videos = <Video>[];
  Future<void> checkFavoriteBoxExists() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();
    Hive.init(themeDatabaseDir.path);
    if (await Hive.boxExists(AppKeyName.favoritesBox)) {
      box = await Hive.openBox(AppKeyName.favoritesBox);
    } else {
      createFavoriteBox();
    }
  }

  Future<void> createFavoriteBox() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();
    Hive.init(themeDatabaseDir.path);
    Hive.registerAdapter(ArticleAdapter());
    box = await Hive.openBox(AppKeyName.favoritesBox);
  }

  void addVideoToFavorite(Video? video) {
    box.put(video?.name, video);
    videos?.add(video);
  }

  List<Video?>? getListFavorite() {
    return videos;
  }

  void removeArticleFromFavorite() {
    
  }
}
