import 'package:bootcamp_todo_app/data/repo/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPageCubit extends Cubit<void> {
  DetailsPageCubit() : super(0);

  var tRepo = TodoRepository();

  Future<void> updateTodo(int id, String name) async {
    await tRepo.updateTodo(id, name);
  }
}
