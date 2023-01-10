import 'package:bootcamp_todo_app/data/repo/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/todo.dart';

class HomeScreenCubit extends Cubit<List<Todo>> {
  HomeScreenCubit() : super(<Todo>[]);

  var tRepo = TodoRepository();

  Future<void> loadTodos() async {
    // we do not need to return anything since we emit the value globally
    var list = await tRepo.loadTodos();
    emit(list);
  }

  Future<void> search(String query) async {
    var list = await tRepo.search(query);
    emit(list);
  }

  Future<void> deleteTodo(int id) async {
    await tRepo.deleteTodo(id);
    await loadTodos();
  }
}
