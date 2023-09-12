import 'package:flutter/material.dart';
import 'package:to_do_app_rest_api/data/task_model.dart';

void patchName(BuildContext context, TextEditingController titleController,
    VoidCallback onPressed, Task task) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white24,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
              ),
              Row(
                children: [
                  const Text('Completed'),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Switch(
                          value: task.completed,
                          onChanged: (value) {
                            setState(
                              () {
                                task.completed = value;
                              },
                            );
                          });
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: onPressed, child: const Text("Done"))
            ],
          ),
        ),
      ),
    ),
  );
}
