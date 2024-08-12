import 'package:flutter/material.dart';
import 'package:messenger/messenger/build_messenger_item.dart';
import 'package:messenger/messenger/build_story_item.dart';
import 'package:messenger/messenger/messenger_model.dart';


class Messenger extends StatelessWidget {
  const Messenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        titleSpacing: 20.0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                'https://scontent.fcai2-2.fna.fbcdn.net/v/t39.30808-6/439241837_454578707258753_7828739239649312642_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=QwlgBrc6IKgQ7kNvgFcKQIn&_nc_ht=scontent.fcai2-2.fna&oh=00_AYDsNt13zR_-wi2liF-TyECluFcMq_hub9YWPYdaVDm1HA&oe=66BEBD6E',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 18.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 18.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 150.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => BuildStoryItem(model: messenger[index],),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10.0,
                  ),
                  itemCount: messenger.length,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => BuildMessengerItem(model: messenger[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
                itemCount: messenger.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
