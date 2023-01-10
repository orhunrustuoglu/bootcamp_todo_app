import 'package:bootcamp_todo_app/data/entity/todo.dart';
import 'package:bootcamp_todo_app/ui/cubit/details_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final Todo todo;
  const DetailsScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: todo.name);

    return Scaffold(
      appBar: AppBar(title: const Text("Todo Details")),
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
                        .read<DetailsPageCubit>()
                        .updateTodo(todo.id, nameController.text);
                    Navigator.pop(context);
                  },
                  child: const Text("UPDATE")),
            ],
          ),
        ),
      ),
    );
  }
}
