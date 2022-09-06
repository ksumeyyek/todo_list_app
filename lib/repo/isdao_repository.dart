import 'package:todo_uygulamasi/entity/todo.dart';

import '../sqlite/database_yardimci.dart';

class IsDaoRepository {
  Future<void> isKayit(String yapilacak_is) async {
    var db =await DatabaseYardimcisi.databaseErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["yapilacak_is"]=yapilacak_is;

    await db.insert("yapilacaklar", bilgiler);
  }

  Future<void> isGuncelle(int yapilacak_id,String yapilacak_is) async{
    var db =await DatabaseYardimcisi.databaseErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["yapilacak_is"]=yapilacak_is;
    await db.update("yapilacaklar", bilgiler,where: "yapilacak_id = ?",whereArgs: [yapilacak_id]);
  }

  Future<List<Todo>> tumIsleriAl() async {
    var db=await DatabaseYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM yapilacaklar");
    return List.generate(maps.length, (indeks) {
      var satir=maps[indeks];
      return Todo(yapilacak_id: satir ["yapilacak_id"], yapilacak_is: satir ["yapilacak_is"]);
    });

  }

  Future<List<Todo>> isAra(String aramaKelimesi) async {
    var db=await DatabaseYardimcisi.databaseErisim();
    List<Map<String,dynamic>> maps =await db.rawQuery("SELECT * FROM yapilacaklar WHERE yapilacak_is like '%$aramaKelimesi%'");
    return List.generate(maps.length, (indeks) {
      var satir=maps[indeks];
      return Todo(yapilacak_id: satir ["yapilacak_id"], yapilacak_is: satir ["yapilacak_is"]);
    });
  }

  Future<void> isSil(int yapilacak_id) async {
    var db =await DatabaseYardimcisi.databaseErisim();
    await db.delete("yapilacaklar",where:"yapilacak_id = ?",whereArgs: [yapilacak_id ]);
  }
}
