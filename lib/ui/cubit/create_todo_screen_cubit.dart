import 'package:bootcamp_todo_app/data/repo/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoScreenCubit extends Cubit<void> {
  CreateTodoScreenCubit() : super(0);

  var tRepo = TodoRepository();

  Future<void> saveTodo(String name) async {
    await tRepo.saveTodo(name);
  }
}
