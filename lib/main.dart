import 'package:flutter/material.dart';
import 'package:todo_uygulamasi/views/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_uygulamasi/cubit/main_cubit.dart';
import 'package:todo_uygulamasi/cubit/detail_cubit.dart';
import 'package:todo_uygulamasi/cubit/entry_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => KayitCubit()),
        BlocProvider(create: (context) => DetayCubit()),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}
