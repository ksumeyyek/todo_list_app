import 'package:todo_uygulamasi/entity/todo.dart';

import '../sqlite/database_yardimci.dart';

class IsDaoRepository {
  Future<void> doEntry(String yapilacak_is) async {
    var db =await DatabaseYardimcisi.databaseErisim();
    var info=Map<String,dynamic>();
    info["yapilacak_is"]=yapilacak_is;

    await db.insert("yapilacaklar", info);
  }

  Future<void> doUpdate(int yapilacak_id,String yapilacak_is) async{
    var db =await DatabaseYardimcisi.databaseErisim();
    var info=Map<String,dynamic>();
    info["yapilacak_is"]=yapilacak_is;
    await db.update("yapilacaklar", info,where: "yapilacak_id = ?",whereArgs: [yapilacak_id]);
  }

  Future<List<Todo>> takeAllDo() async {
    var db=await DatabaseYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM yapilacaklar");
    return List.generate(maps.length, (indeks) {
      var line=maps[indeks];
      return Todo(yapilacak_id: line ["yapilacak_id"], yapilacak_is: line ["yapilacak_is"]);
    });

  }

  Future<List<Todo>> doSearch(String aramaKelimesi) async {
    var db=await DatabaseYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM yapilacaklar WHERE yapilacak_is like '%$aramaKelimesi%'");
    return List.generate(maps.length, (indeks) {
      var line=maps[indeks];
      return Todo(yapilacak_id: line ["yapilacak_id"], yapilacak_is: line ["yapilacak_is"]);
    });
  }

  Future<void> doDelete(int yapilacak_id) async {
    var db =await DatabaseYardimcisi.databaseErisim();
    await db.delete("yapilacaklar",where:"yapilacak_id = ?",whereArgs: [yapilacak_id ]);
  }
}
