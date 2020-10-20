import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/app/db/db_manager.dart';
import 'package:flutter_demo/app/utils/log.dart';
import 'package:sqflite/sqflite.dart';

class ImgDBHelper {
  DBManager _sql;

  static final ImgDBHelper _instance = new ImgDBHelper.internal();

  static ImgDBHelper get instance => _instance;

  ImgDBHelper.internal() {
    _sql = DBManager();
  }

  Future<int> insertImg(ImgBean imgBean) async {
    var dbClient = await _sql.db;

    List<Map> hasList = await dbClient.rawQuery(
        "SELECT * FROM ${DBManager.tableImg} WHERE enddate=${imgBean.enddate}");

    var result = 0;
    if (hasList.length > 0) {
      L.d("需要插入到数据库的数据已经存在");
      // result = await dbClient.update(ReadSQL.tableShelf, bookShelf.toMap(),
      //     where: "bookId = ?", whereArgs: [bookShelf.bookId]);
    } else {
      result = await dbClient.insert(DBManager.tableImg, imgBean.toMap());
    }
    return result;
  }

  Future<List<ImgBean>> getImgs() async {
    var dbClient = await _sql.db;
    List<Map> maps =
        await dbClient.rawQuery("SELECT * FROM ${DBManager.tableImg} ORDER BY enddate DESC");
    if (maps == null || maps.length == 0) {
      return null;
    }
    List<ImgBean> list = [];
    maps.forEach((it) {
      list.add(ImgBean.createFromMap(it));
    });

    return list;
  }

  //date like "20201012"
  Future<ImgBean> getImg(String date) async {
    var dbClient = await _sql.db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM ${DBManager.tableImg} WHERE enddate=$date");
    if (maps == null || maps.length == 0) {
      return null;
    }
    return ImgBean.createFromMap(maps[0]);
  }
}
