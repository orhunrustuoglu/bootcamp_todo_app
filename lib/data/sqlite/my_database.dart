import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static const String databaseName = "todo_database.sqlite";

  static Future<Database> accessToDb() async {
    String dbPath = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(dbPath)) {
      print("Database exists!");
    } else {
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPath).writeAsBytes(bytes,
          flush:
              true); //flush is recommended to prevent possible data loss while writing
      print("Database copied!");
    }
    return openDatabase(dbPath);
  }
}
