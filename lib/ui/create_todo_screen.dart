import 'package:bootcamp_todo_app/ui/cubit/create_todo_screen_cubit.dart';
import 'package:bootcamp_todo_app/ui/cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoScreen extends StatelessWidget {
  const CreateTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Create a Todo")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Todo Name"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CreateTodoScreenCubit>()
                        .saveTodo(nameController.text)
                        .then(
                            (_) => context.read<HomeScreenCubit>().loadTodos());
                    Navigator.pop(context);
                  },
                  child: const Text("KAYDET")),
            ],
          ),
        ),
      ),
    );
  }
}
