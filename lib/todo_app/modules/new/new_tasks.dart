import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/widgets/build_task.dart';
import 'package:messenger/core/widgets/build_task_item.dart';
import 'package:messenger/todo_app/layout/cubit/cubit.dart';
import 'package:messenger/todo_app/layout/cubit/state.dart';


class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return BuildTask(tasks: tasks);
      },
    );
  }
}
