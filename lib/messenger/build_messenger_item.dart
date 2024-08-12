import 'package:flutter/material.dart';
import 'package:messenger/messenger/messenger_model.dart';


class BuildMessengerItem extends StatelessWidget {
  final MessengerModel model;

  const BuildMessengerItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 37,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    model.image,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10.0,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 8.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16.0),
              ),
              Text(
                model.type,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        const CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 5,
        ),
        const SizedBox(
          width: 10.0,
        ),
        const Text(
          '2:00 pm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
