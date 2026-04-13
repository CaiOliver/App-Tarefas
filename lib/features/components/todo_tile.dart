import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../todo_list/view_model/theme_view_model.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskTitle;
  final bool taskCompleted;
  void Function(bool?)? onChanged;
  void Function()? onPressed;
  void Function(BuildContext)? deleteOnPressed;

  TodoTile({
    super.key,
    required this.taskTitle,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteOnPressed,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: context.watch<ThemeViewModel>().isDark
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
                  children: [
                    Checkbox(
                      value: taskCompleted,
                      onChanged: onChanged,
                      checkColor: context.watch<ThemeViewModel>().isDark
                          ? Colors.white
                          : Colors.black,
                      activeColor: context.watch<ThemeViewModel>().isDark
                          ? Colors.black
                          : Colors.white,
                      side: BorderSide(
                        color: context.watch<ThemeViewModel>().isDark
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Text(
                      taskTitle,
                      style: TextStyle(
                        color: context.watch<ThemeViewModel>().isDark
                            ? Colors.black
                            : Colors.white,
                        decorationColor: context.watch<ThemeViewModel>().isDark
                            ? Colors.black
                            : Colors.white,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
