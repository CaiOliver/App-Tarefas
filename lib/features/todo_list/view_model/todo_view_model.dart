import 'package:flutter/material.dart';
import '../model/task.dart';
import 'package:hive/hive.dart';

class TodoViewModel extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('todoBox');

  // a _taskBox é a lista
  List<Task> get task => _taskBox.values.toList();

  void addTask(String title) {
    if (title.isNotEmpty) {
      final newTask = Task(title: title);
      _taskBox.add(newTask);
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    _taskBox.deleteAt(index);
    notifyListeners();
  }

  void checkDone(int index) {
    final taskUpdate = _taskBox.getAt(index);
    if (taskUpdate != null) {
      taskUpdate.isDone = !taskUpdate.isDone;
      taskUpdate.save();
      notifyListeners();
    }
  }
}
