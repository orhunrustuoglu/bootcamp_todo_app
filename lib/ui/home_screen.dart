import 'package:bootcamp_todo_app/data/entity/todo.dart';
import 'package:bootcamp_todo_app/ui/create_todo_screen.dart';
import 'package:bootcamp_todo_app/ui/cubit/home_screen_cubit.dart';
import 'package:bootcamp_todo_app/ui/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (query) {
                  print("Search a Todo : $query");
                  context.read<HomeScreenCubit>().search(query);
                },
              )
            : const Text("My Todo List"),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      context.read<HomeScreenCubit>().loadTodos();
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<HomeScreenCubit, List<Todo>>(
          builder: (context, todoList) {
        if (todoList.isNotEmpty) {
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(todo: todoList[i])))
                      .then((_) => context.read<HomeScreenCubit>().loadTodos()),
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        todoList[i].id.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(todoList[i].name),
                      trailing: IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Delete ${todoList[i].name}?"),
                                action: SnackBarAction(
                                  label: "Yes",
                                  onPressed: () {
                                    print("Delete Todo : ${todoList[i].name}");
                                    context
                                        .read<HomeScreenCubit>()
                                        .deleteTodo(todoList[i].id);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          )),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: Text("Nothing to do... 😐"),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateTodoScreen()))
              .then((_) => context.read<HomeScreenCubit>().loadTodos());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
