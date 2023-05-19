import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});
  static String id = "comments_page";

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
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

  // List filedata = [
  //   {
  //     'name': 'Chuks Okwuenu',
  //     'pic': 'https://picsum.photos/300/30',
  //     'message': 'I love to code',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Tunde Martins',
  //     'pic': 'assets/img/userpic.jpg',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  //   {
  //     'name': 'Biggi Man',
  //     'pic': 'https://picsum.photos/300/30',
  //     'message': 'Very cool',
  //     'date': '2021-01-01 12:00:00'
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/img/userpic.jpg"),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              _firestore.collection("messages").add(
                {
                  "text": messageText,
                  "sender": loggedInUser?.email,
                },
              );
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          sendWidget:
              const Icon(Icons.send_sharp, size: 30, color: Colors.white),
          child: commentChild(),
        ),
      ),
    );
  }

  Widget commentChild() {
    return StreamBuilder(
      stream: _firestore.collection("messages").snapshots(),
      builder: (context, snapshot) {
        List<dynamic> messagesList = [];

        if (snapshot.hasError) {
          print(snapshot.error);
          return const Text("Something went wrong");
        } else if (snapshot.hasData) {
          final users = snapshot.data?.docs.reversed;

          for (var user in users!) {
            // final messageText = user.data()["text"];
            // final messageSender = user.data()["sender"];
            final userEmail = user.data()["email"];
            final userName = user.data()["name"];
            final userPhoto = user.data()["photo"];

            final currentUser = loggedInUser?.email;

            final messageItem = {
              "name": userName,
              "email": userEmail,
              "photo": userPhoto
            };

            messagesList.add(messageItem);
          }
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const LinearProgressIndicator();
          case ConnectionState.active:
            return Expanded(
              child: ListView.builder(
                  itemCount: messagesList.length,
                  itemBuilder: (_, index) {
                    var element = messagesList[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () async {
                            // Display the image in large form.
                            print("Comment Clicked");
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: CommentBox.commentImageParser(
                                    imageURLorPath:
                                        'https://picsum.photos/300/30')),
                          ),
                        ),
                        title: Text(
                          element['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(element['message']),
                        // trailing: Text(element['date'],
                        //     style: const TextStyle(fontSize: 10)),
                      ),
                    );
                  }),
            );
          case ConnectionState.done:
            return Expanded(
              child: ListView.builder(
                  itemCount: messagesList.length,
                  itemBuilder: (_, index) {
                    var element = messagesList[index];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () async {
                            // Display the image in large form.
                            print("Comment Clicked");
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: CommentBox.commentImageParser(
                                    imageURLorPath:
                                        'https://picsum.photos/300/30')),
                          ),
                        ),
                        title: Text(
                          element['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(element['message']),
                        // trailing: Text(element['date'],
                        //     style: const TextStyle(fontSize: 10)),
                      ),
                    );
                  }),
            );
        }
      },
    );

    //   ListView.builder(
    //   itemCount: data.lenght,
    //   itemBuilder: (_,index){
    //     var element = data[index];
    //
    //     return Padding(
    //       padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
    //       child: ListTile(
    //         leading: GestureDetector(
    //           onTap: () async {
    //             // Display the image in large form.
    //             print("Comment Clicked");
    //           },
    //           child: Container(
    //             height: 50.0,
    //             width: 50.0,
    //             decoration:const BoxDecoration(
    //                 color: Colors.blue,
    //                 borderRadius: BorderRadius.all(Radius.circular(50))),
    //             child: CircleAvatar(
    //                 radius: 50,
    //                 backgroundImage: CommentBox.commentImageParser(
    //                     imageURLorPath: element['pic'])),
    //           ),
    //         ),
    //         title: Text(
    //           element['name'],
    //           style:const TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         subtitle: Text(element['message']),
    //         trailing: Text(element['date'], style:const TextStyle(fontSize: 10)),
    //       ),
    //     );
    //   }
    // );
  }
}
