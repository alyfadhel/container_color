import 'package:flutter/material.dart';
import 'package:messenger/messenger/messenger_model.dart';


class BuildStoryItem extends StatelessWidget {
  final MessengerModel model;
  const BuildStoryItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
