import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReadSQL{
  static const String tableShelf = "bookShelf";
  static const String tableCatalog = "bookCatalog";

  final String dropTableShelf = "DROP TABLE IF EXISTS $tableShelf";
  final String createTableShelf = "CREATE TABLE $tableShelf (id INTEGER PRIMARY KEY AUTOINCREMENT, bookId TEXT"
      ",title TEXT,readers REAL,briefIntro TEXT,charactersCount INTEGER"
      ",chaptersCount INTEGER,cover TEXT,serialState INTEGER"
      ",majorCateId TEXT,majorCateName TEXT"
      ",minorCateId TEXT,minorCateName TEXT"
      ",ratio REAL,author TEXT,lastReadTime INTEGER)";


  final String dropTableCatalog = "DROP TABLE IF EXISTS $tableCatalog";
  final String createTableCatalog = "CREATE TABLE $tableCatalog (id INTEGER PRIMARY KEY AUTOINCREMENT, mixCode TEXT"
      ",bookId TEXT,chapterTitle TEXT,chapterId INTEGER,status INTEGER)";

  Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await _initDb();
    }
    return _db;
  }

  _initDb() async{
    String basePath = await getDatabasesPath();
    String path = join(basePath,"read.db");
    Database db = await openDatabase(path,version: 2,onCreate: _onCreate,onUpgrade: _onUpgrade);
    return db;

  }

  Future close() async {
    var result = _db.close();
    _db = null;
    return result;
  }

  void _onCreate(Database db, int newVersion) async{
    print("_onCreate newVersion:$newVersion");
    var batch = db.batch();
    batch.execute(dropTableShelf);
    batch.execute(createTableShelf);

    batch.execute(dropTableCatalog);
    batch.execute(createTableCatalog);
    await batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion,int newVersion)async{
    print("_onUpgrade oldVersion:$oldVersion");
    print("_onUpgrade newVersion:$newVersion");

    var batch = db.batch();
    if(oldVersion == 1){
      batch.execute(dropTableCatalog);
      batch.execute(createTableCatalog);
    }

    await batch.commit();

  }
}