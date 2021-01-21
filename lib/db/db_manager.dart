import 'package:bing_flutter/my_all_imports.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static const String imgDbName = 'bing.db';
  static const String tableImg = '_img_tab';

  static const String imgId = 'id';
  static const String date = 'enddate';
  static const String url = 'url';
  static const String copyright = 'copyright';

  final String dropTableCatalog = 'DROP TABLE IF EXISTS $tableImg';
  final String createTableCatalog = 'CREATE TABLE $tableImg '
      '($imgId INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $date TEXT,$url TEXT,$copyright TEXT)';

  Database _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final basePath = await getDatabasesPath();
    final path = join(basePath, imgDbName);
    final Database db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  Future close() async {
    final result = _db.close();
    _db = null;
    return result;
  }

  Future _onCreate(Database db, int newVersion) async {
    logD('_onCreate newVersion:$newVersion');
    final batch = db.batch();

    batch.execute(dropTableCatalog);
    batch.execute(createTableCatalog);
    await batch.commit();
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    logD('_onUpgrade oldVersion:$oldVersion');
    logD('_onUpgrade newVersion:$newVersion');

    final batch = db.batch();
    if (oldVersion == 1) {
      batch.execute(dropTableCatalog);
      batch.execute(createTableCatalog);
    }

    await batch.commit();
  }
}
