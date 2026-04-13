import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../model/task.dart';

class TodoDatabase {
  final String _todoBox = 'todoBox';
  Future<Box<Task>> get _box async => await Hive.openBox<Task>(_todoBox);

  Future<void> insert(Task task) async {
    var box = await _box;
    await box.add(task);
  }

  Future<List<Task>> getAll() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> update(Task task) async {
    await task.save();
  }

  Future<void> delete(Task task) async {
    await task.delete();
  }
}
