import 'package:bootcamp_todo_app/ui/cubit/create_todo_screen_cubit.dart';
import 'package:bootcamp_todo_app/ui/cubit/details_page_cubit.dart';
import 'package:bootcamp_todo_app/ui/cubit/home_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => DetailsPageCubit()),
        BlocProvider(create: (context) => CreateTodoScreenCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
