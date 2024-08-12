import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/widgets/build_task_item.dart';

class BuildTask extends StatelessWidget {
  final List<Map> tasks;

  const BuildTask({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => BuildTaskItem(
          model: tasks[index],
        ),
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Tasks Yet',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.3),
              ),
            ),
            Icon(
              Icons.menu,
              color: Colors.black.withOpacity(
                .3,
              ),
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
