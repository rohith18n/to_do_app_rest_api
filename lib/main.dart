import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_rest_api/bloc/task_bloc.dart';
import 'package:to_do_app_rest_api/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                elevation: 1, backgroundColor: Colors.blueGrey.shade900),
            scaffoldBackgroundColor: Colors.blueGrey.shade900),
        home: ScreenHome(),
      ),
    );
  }
}
