import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseYardimcisi{
  static final String databaseAdi="todo.sqlite";

  static Future<Database> databaseErisim() async{
    String databaseYolu=join(await getDatabasesPath(),databaseAdi);

    if(await databaseExists(databaseYolu)){
      print("veritabanı zaten var");
    }else{
      //koplama işlemi yapılıcak
      ByteData data=await rootBundle.load("databasee/$databaseAdi");
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(databaseYolu).writeAsBytes(bytes,flush:true);
      print("veritabanı kopyalandı");
    }
    return openDatabase(databaseYolu);
  }
}
