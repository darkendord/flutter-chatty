import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum Reaction { like, laugh, love, none }

class ReactionController extends StatefulWidget {
  const ReactionController({Key? key}) : super(key: key);

  @override
  State<ReactionController> createState() => _ReactionControllerState();
}

class _ReactionControllerState extends State<ReactionController> {
  Reaction _reaction = Reaction.none;
  bool _reactionView = false;

  final List<ReactionElement> reactions = [
    ReactionElement(
      Reaction.like,
      const Icon(
        Icons.thumb_up,
        color: Colors.blue,
      ),
    ),
    ReactionElement(
      Reaction.love,
      const Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    ),
    ReactionElement(
      Reaction.laugh,
      const Icon(
        Icons.emoji_emotions,
        color: Colors.purple,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_reactionView)
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reactions.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 15 + index * 15,
                    child: FadeInAnimation(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _reaction = reactions[index].reaction;
                            _reactionView = false;
                          });
                        },
                        icon: reactions[index].icon,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        else
          const SizedBox(
            height: 40,
            width: 140,
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
