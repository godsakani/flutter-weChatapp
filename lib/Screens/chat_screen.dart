import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/message_widget.dart';
import '../widgets/streammessage_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const String id = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? messageText;
  String? loginUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      final uid = user?.uid;
      final email = user?.email;
      if (user != null) {
        print(uid);
        loginUser = email.toString();
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  void messagesStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // _auth.signOut();
              // Navigator.pop(context);
              messagesStream();
            },
            icon: Icon(Icons.close),
          )
        ],
        backgroundColor: primaryColor,
        title: Text('weChat'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(firestore: _firestore),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter message here',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection("messages").add({
                      'text': messageText,
                      'sender': loginUser,
                    });
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                      color: Color(0xFF71ae87),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
