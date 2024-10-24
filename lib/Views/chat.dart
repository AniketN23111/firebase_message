import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final RemoteMessage? remoteMessage;
  const Chat({super.key, this.remoteMessage});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Chat App"),
            Text('${widget.remoteMessage!.data}'),
          ],
        ),
      ),
    );
  }
}
