import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
  }) : super(key: key);

  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 5.0,
            color: Color(0xFF71ae87),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
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
