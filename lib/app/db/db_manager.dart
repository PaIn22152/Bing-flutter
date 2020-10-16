import 'package:flutter_demo/app/utils/Log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ReadSQL{
  static const String tableImg = "_img_tab";

  final String dropTableCatalog = "DROP TABLE IF EXISTS $tableImg";
  final String createTableCatalog = "CREATE TABLE $tableImg (id INTEGER PRIMARY KEY AUTOINCREMENT, enddate TEXT,url TEXT,copyright TEXT)";

  Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await _initDb();
    }
    return _db;
  }

  _initDb() async{
    String basePath = await getDatabasesPath();
    String path = join(basePath,"bing.db");
    Database db = await openDatabase(path,version: 2,onCreate: _onCreate,onUpgrade: _onUpgrade);
    return db;

  }

  Future close() async {
    var result = _db.close();
    _db = null;
    return result;
  }

  void _onCreate(Database db, int newVersion) async{
    L.d("_onCreate newVersion:$newVersion");
    var batch = db.batch();

    batch.execute(dropTableCatalog);
    batch.execute(createTableCatalog);
    await batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion,int newVersion)async{
    L.d("_onUpgrade oldVersion:$oldVersion");
    L.d("_onUpgrade newVersion:$newVersion");

    var batch = db.batch();
    if(oldVersion == 1){
      batch.execute(dropTableCatalog);
      batch.execute(createTableCatalog);
    }

    await batch.commit();

  }
}