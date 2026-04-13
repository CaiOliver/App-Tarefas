import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  Task({required this.title, this.isDone = false});
}

/*class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}
*/
