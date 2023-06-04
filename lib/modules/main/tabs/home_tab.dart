import 'package:flutter/material.dart';

import '../../../widgets/reaction_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Map<String, dynamic>> postList = [
    {
      "date": "6/3/2020",
      "media": "assets/images/article1.jpg",
      "title": "Titulo de la publicasion",
      "textContent": "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s, when an unknown "
          "printer took a galley of type and scrambled it to make a type "
          "specimen book.",
    },
    {
      "date": "6/3/2020",
      "media": "assets/images/post2.webp",
      "title": "Titulo de la publicasion",
      "textContent": "Lorem Ipsum is simply dummy text of the printing and "
          "typesetting industry. Lorem Ipsum has been the industry's "
          "standard dummy text ever since the 1500s, when an unknown "
          "printer took a galley of type and scrambled it to make a type "
          "specimen book.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: _articleBuilder(context),
      ),
    );
  }

  Widget _articleBuilder(BuildContext context) {
    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: (context, index) {
        var post = postList[index];
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Expanded(
                              child: Image.asset(
                                "assets/images/profile1.jpg",
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Adonis Paniagua",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Text(
                        post["date"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  post["media"],
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  post["title"],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  post["textContent"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ReactionController()
              ],
            ),
          ),
        );
      },
    );
  }
}
