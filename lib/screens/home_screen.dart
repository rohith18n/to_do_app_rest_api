import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_rest_api/bloc/task_bloc.dart';
import 'package:to_do_app_rest_api/widgets/snackbar.dart';
import 'package:to_do_app_rest_api/widgets/task_container.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(InitTaskEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Your Tasks',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<TaskBloc, TaskState>(
                listenWhen: (previous, current) => current is TaskActionState,
                listener: (context, state) {
                  if (state is TaskEditedState) {
                    showSnackBarMessenger(
                        context: context,
                        color: Colors.green,
                        message: 'Task Edited Successfully');
                  } else if (state is TaskDeletedState) {
                    showSnackBarMessenger(
                        context: context,
                        message: 'Task Deleted Successfully',
                        color: Colors.red);
                  }
                },
                buildWhen: (previous, current) => current is! TaskActionState,
                builder: (context, state) {
                  if (state is TaskFetchSuccessfullState) {
                    final taskList = state.taskList;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final data = taskList[index];

                        return TaskContainer(data: data);
                      },
                      itemCount: taskList.length,
                    );
                  } else if (state is TaskLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else {
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
