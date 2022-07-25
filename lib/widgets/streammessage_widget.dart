import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_widget.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").snapshots(),
        initialData: null,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data.docs;
            List<MessageBubble> messageBubbles = [];
            for (var message in messages) {
              final messageSender = message['sender'];
              final messageText = message['text'];
              final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
              );

              messageBubbles.add(messageBubble);
            }
            return Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                children: messageBubbles,
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
