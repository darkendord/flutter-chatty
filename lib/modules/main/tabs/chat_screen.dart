import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = "chat_screen.";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String? messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _messageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection("messages").add(
                        {
                          "text": messageText,
                          "sender": loggedInUser?.email,
                        },
                      );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _messageStream() {
  return StreamBuilder(
    stream: _firestore.collection("messages").snapshots(),
    builder: (context, snapshot) {
      List<MessageBuble> messageBubles = [];

      if (snapshot.hasError) {
        print(snapshot.error);
        return const Text("Something went wrong");
      } else if (snapshot.hasData) {
        final messages = snapshot.data?.docs.reversed;

        for (var message in messages!) {
          final messageText = message.data()["text"];
          final messageSender = message.data()["sender"];

          final currentUser = loggedInUser?.email;

          final messageBuble = MessageBuble(
              sender: messageSender,
              text: messageText,
              isCurrentUser: currentUser == messageSender);

          messageBubles.add(messageBuble);
        }
      }

      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
        case ConnectionState.none:
          return const LinearProgressIndicator();
        case ConnectionState.active:
          return Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              itemCount: messageBubles.length,
              itemBuilder: (context, index) {
                return messageBubles[index];
              },
            ),
          );
        case ConnectionState.done:
          return Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              itemCount: messageBubles.length,
              itemBuilder: (context, index) {
                return messageBubles[index];
              },
            ),
          );
      }
    },
  );
}

class MessageBuble extends StatelessWidget {
  const MessageBuble(
      {Key? key,
      required this.sender,
      required this.text,
      required this.isCurrentUser})
      : super(key: key);

  final String sender;
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
            elevation: 5,
            color: isCurrentUser ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
// void getMessages() async {
  //   final messages = await _firestore.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection("messages").snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }
 */
