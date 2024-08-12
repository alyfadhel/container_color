import 'package:flutter/material.dart';
import 'package:messenger/todo_app/layout/cubit/cubit.dart';

class BuildTaskItem extends StatelessWidget {
  final Map model;

  const BuildTaskItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction)
      {
        AppCubit.get(context).deleteDataFromDatabase(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              child: Text(
                model['time'],
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    model['date'],
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDataFromDatabase(status: 'done', id: model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDataFromDatabase(status: 'archive', id: model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
