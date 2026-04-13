import 'package:flutter/material.dart';
import 'package:todolistraw/features/components/button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancell;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancell,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'New task...',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Save Button
                Button(text: 'Save', onPressed: onSave),
                //Cancel Button
                Button(text: 'Cancel', onPressed: onCancell),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
