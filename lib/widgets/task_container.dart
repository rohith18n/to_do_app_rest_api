import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_rest_api/bloc/task_bloc.dart';
import 'package:to_do_app_rest_api/data/task_model.dart';
import 'package:to_do_app_rest_api/widgets/bottom_sheet.dart';

class TaskContainer extends StatelessWidget {
  TaskContainer({
    super.key,
    required this.data,
  });
  final Task data;
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isCompleted = data.completed;
    titleController.text = data.title;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white70,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Divider(
            height: 0.5,
            thickness: 3,
            color: Colors.grey.shade700,
          ),
          Row(
            children: [
              const Text('Task completed'),
              StatefulBuilder(
                builder: (context, setState) {
                  return Switch(
                    value: isCompleted,
                    onChanged: (value) {
                      setState(
                        () {
                          isCompleted = value;
                          context.read<TaskBloc>().add(PatchTaskEvent(
                              body: {"completed": isCompleted}, id: data.id));
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(id: data.id));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFFFF1744),
                  )),
              IconButton(
                onPressed: () {
                  patchName(context, titleController, () {
                    updateTask(context, data);
                    titleController.clear();
                    Navigator.of(context).pop();
                  }, data);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.indigo,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  updateTask(BuildContext context, Task task) {
    final updatedTask = {
      "userId": task.id,
      "id": task.id,
      "title": titleController.text,
      "completed": task.completed
    };
    context
        .read<TaskBloc>()
        .add(UpdateTaskEvent(body: updatedTask, id: task.id));
  }
}
