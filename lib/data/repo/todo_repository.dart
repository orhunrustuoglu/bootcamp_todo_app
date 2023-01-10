import 'package:bootcamp_todo_app/data/entity/todo.dart';
import 'package:bootcamp_todo_app/data/sqlite/my_database.dart';

class TodoRepository {
  Future<List<Todo>> loadTodos() async {
    var db = await MyDatabase.accessToDb();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM toDos");

    return List.generate(maps.length, (i) {
      var line = maps[i];
      print(line);
      return Todo(
        id: line["id"],
        name: line["name"],
      );
    });
  }

  Future<List<Todo>> search(String query) async {
    var db = await MyDatabase.accessToDb();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM toDos WHERE name like '%$query%'"); //case in-sensitive
    return List.generate(maps.length, (i) {
      var line = maps[i];
      return Todo(
        id: line["id"],
        name: line["name"],
      );
    });
  }

  Future<void> saveTodo(String name) async {
    var db = await MyDatabase.accessToDb();
    var dataSet = <String, dynamic>{};
    dataSet["name"] = name;
    await db.insert("toDos", dataSet);
  }

  Future<void> updateTodo(int id, String name) async {
    var db = await MyDatabase.accessToDb();
    var dataSet = <String, dynamic>{};
    dataSet["id"] = id;
    dataSet["name"] = name;

    await db.update("toDos", dataSet, where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteTodo(int id) async {
    var db = await MyDatabase.accessToDb();
    db.delete("toDos", where: "id=?", whereArgs: [id]);
  }
}
