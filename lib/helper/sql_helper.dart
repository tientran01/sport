// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static SQLHelper shared = SQLHelper._internal();
  SQLHelper._internal();
  late Future<Database> database;

  Future<Database> get getDatabase async {
    if (database != null) {
      return database;
    }
    database = initDatabase();
    return database;
  }

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, AppKeyName.newsDB);
    database = openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        createVideoTable(db);
      },
    );
    return database;
  }

  Future<void> createVideoTable(Database database) async {
    String? sql = await rootBundle.loadString("assets/sql/init_db.sql");
    database.execute(sql);
  }

  Future<void> createArticle(YourArticle yourArticle) async {
    final db = await getDatabase;
    await db.insert(
      AppKeyName.yourArticleTable,
      yourArticle.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<YourArticle>> getAllYourArticle() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT title, author, publishedAt, describe, urlToImage FROM YourArticle');
    return results.map((e) => YourArticle.fromJson(e)).toList();
  }

  Future<void> deleteYourArticle(int id) async {
    final db = await getDatabase;
    try {
      await db.delete(
        AppKeyName.yourArticleTable,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      Loading.showError(e.toString());
    }
  }
}
