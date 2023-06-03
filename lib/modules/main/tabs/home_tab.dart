import 'package:flutter/material.dart';

enum Reaction { like, laugh, love, none }

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Reaction _reaction = Reaction.none;
  bool _reactionView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _articleBuilder(context),
                    controller(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _articleBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset(
            "assets/images/article1.jpg",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: const Text(
            "Titulo de la publicasion",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: const Text(
            "Lorem Ipsum is simply dummy text of the printing and "
            "typesetting industry. Lorem Ipsum has been the industry's "
            "standard dummy text ever since the 1500s, when an unknown "
            "printer took a galley of type and scrambled it to make a type "
            "specimen book.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget controller() {
    return Column(
      children: [
        if (_reactionView)
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50)),
          ),
        InkWell(
          onTap: () {
            if (_reactionView) {
              _reactionView = false;
            } else {
              if (_reaction == Reaction.none) {
                _reaction = Reaction.like;
              } else {
                _reaction = Reaction.none;
              }
            }
            setState(() {});
          },
          onLongPress: () {
            setState(() {
              _reactionView = true;
            });
          },
          child: getReactionIcon(_reaction),
        ),
      ],
    );
  }

  Widget getReactionIcon(Reaction reaction) {
    if (reaction == Reaction.like) {
      return const Icon(
        Icons.thumb_up,
        color: Colors.blue,
      );
    } else if (reaction == Reaction.love) {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
    } else if (reaction == Reaction.laugh) {
      return const Icon(
        Icons.emoji_emotions,
        color: Colors.purple,
      );
    } else {
      return const Icon(
        Icons.thumb_up,
      );
    }
  }
}

class ReactionElement {
  final Reaction reaction;
  final Icon icon;

  ReactionElement(this.reaction, this.icon);
}
