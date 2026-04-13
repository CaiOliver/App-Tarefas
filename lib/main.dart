import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/todo_list/view/todo_view.dart';
import 'features/todo_list/view_model/todo_view_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/todo_list/model/task.dart';
import 'features/todo_list/view_model/theme_view_model.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('todoBox');
  await Hive.openBox('settings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeViewModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoView(),
      themeMode: themeNotifier.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(primary: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(primary: Colors.white),
      ),
    );
  }
}
