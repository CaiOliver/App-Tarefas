import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/todo_view_model.dart';
import '../../components/todo_tile.dart';
import '../../components/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../view_model/theme_view_model.dart';
import 'package:flutter/services.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  // ignore: unused_field
  final _todoBox = Hive.openBox('todoBox');

  final TextEditingController _controller = TextEditingController();
  // task list

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancell: Navigator.of(context).pop,
        );
      },
    );
  }

  void saveTask() {
    String newTaskName = _controller.text;
    if (newTaskName.isNotEmpty) {
      context.read<TodoViewModel>().addTask(newTaskName);
      _controller.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<TodoViewModel>();
    return Scaffold(
      //backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: Text(
          'TAREFAS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeViewModel>().changeTheme();
            },
            icon: Icon(
              context.watch<ThemeViewModel>().isDark
                  ? Icons.dark_mode
                  : Icons.sunny,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(child: Icon(Icons.note)),

                Divider(),

                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Exit'),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: viewModel.task.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskTitle: viewModel.task[index].title,
            taskCompleted: viewModel.task[index].isDone,
            onChanged: (value) => viewModel.checkDone(index),
            deleteOnPressed: (context) => viewModel.deleteTask(index),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
