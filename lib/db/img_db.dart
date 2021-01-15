import 'package:bing_flutter/my_all_imports.dart';

class ImgDBHelper {
  ///数据库操作语句

  ///数据库操作语句

  DBManager _sql;

  static final ImgDBHelper _instance = ImgDBHelper._internal();

  static ImgDBHelper get instance => _instance;

  ImgDBHelper._internal() {
    _sql = DBManager();
  }

  Future<int> insertImg(ImgBean imgBean) async {
    final dbClient = await _sql.db;

    final List<Map> hasList = await dbClient.query(DBManager.tableImg,
        where: '${DBManager.date} = ?', whereArgs: [imgBean.enddate]);

    var result = 0;
    if (hasList.isNotEmpty) {
      logD('需要插入到数据库的数据已经存在');
      // result = await dbClient.update(ReadSQL.tableShelf, bookShelf.toMap(),
      //     where: "bookId = ?", whereArgs: [bookShelf.bookId]);
      return -1;
    } else {
      result = await dbClient.insert(DBManager.tableImg, imgBean.toMap());
    }
    return result;
  }

  Future<List<ImgBean>> getImgs() async {
    // final dbClient = await _sql.db;
    // final List<Map<String, dynamic>> maps =
    //     await dbClient.rawQuery(sql_select_all_img_date_desc());
    // if (maps == null || maps.isEmpty) {
    //   return null;
    // }
    // final List<ImgBean> list = [];
    // maps.forEach((it) {
    //   list.add(ImgBean.createFromMap(it));
    // });

    return null;
  }

  //date like "20201012"
  Future<ImgBean> getImg(String date) async {
    // final dbClient = await _sql.db;
    // final List<Map<String, dynamic>> maps =
    //     await dbClient.rawQuery(sql_select_by_date(date));
    // if (maps == null || maps.isEmpty) {
    //   return null;
    // }
    // return ImgBean.createFromMap(maps[0]);
    return null;
  }
}
