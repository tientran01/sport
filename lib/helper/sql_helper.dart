import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sport_app/helper/firebase_helper.dart';
import 'package:sport_app/helper/loading.dart';
import 'package:sport_app/model/your_article.dart';
import 'package:sport_app/resource/resource.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static SQLHelper shared = SQLHelper._internal();
  SQLHelper._internal();
  late Future<Database> database;
  User? user = FirebaseHelper.shared.auth.currentUser;

  Future<Database> get getDatabase async {
    // ignore: unnecessary_null_comparison
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
        createTable(db);
      },
    );
    return database;
  }

  Future<void> createTable(Database database) async {
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

  Future<void> deleteYourArticle(int id) async {
    final db = await getDatabase;
    try {
      await db.delete(
        AppKeyName.yourArticleTable,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      Loading.showError(msg: e.toString());
    }
  }

  Future<void> updateYourArticle(YourArticle yourArticle) async {
    Map<String, dynamic> values = {
      'title': yourArticle.title,
      'describe': yourArticle.describe,
      'publishedAt': yourArticle.publishedAt,
    };
    final db = await getDatabase;
    db.update(
      AppKeyName.yourArticleTable,
      values,
      where: "id = ?",
      whereArgs: [yourArticle.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<YourArticle>> sortYourArticleByDate() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT * FROM YourArticle WHERE author = ? ORDER BY datetime(publishedAt) DESC',
        [user?.email]);
    return results.map((e) => YourArticle.fromJson(e)).toList();
  }

  Future<List<YourArticle>> sortYourArticleByAlphabet() async {
    final db = await getDatabase;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT * FROM YourArticle WHERE author = ? ORDER BY title COLLATE NOCASE ASC',
        [user?.email]);
    return results.map((e) => YourArticle.fromJson(e)).toList();
  }

  Future<List<YourArticle>> filterYourArticleByDate(String? date) async {
    final db = await getDatabase;
    List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT * FROM YourArticle WHERE date(publishedAt) = ? AND author = ?',
        [date, user?.email]);
    return results.map((e) => YourArticle.fromJson(e)).toList();
  }
}
